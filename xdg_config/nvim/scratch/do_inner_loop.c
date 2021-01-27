CmdlineLoopResult_T *do_inner_loop(CmdlineContext_T *ctx)
{
  static int recursive = 0;             // recursive depth

  CmdlineLoopResult_T *result = xmalloc(sizeof(CmdlineLoopResult_T));
  result->initial_msg_didout = 0;
  result->did_inc = false;
  result->retval = OK;

  assert(ctx != NULL);
  if (ctx == NULL) {
    result->retval = FAIL;
    return result;
  }

  char_u *cmdline = ctx->cmdline;
  LineGetter fgetline = ctx->fgetline;
  void *cookie = ctx->cookie;
  void *real_cookie = ctx->real_cookie;

  int flags = ctx->flags;
  cstack_T *cstack = ctx->cstack;

  char_u      *next_cmdline;            // next cmd to execute
  int used_getline = false;             // used "fgetline" to obtain command

  char_u      *cmdline_copy = NULL;     // copy of cmd line
  int current_line = 0;                 // active line in lines_ga
  int count = 0;                        // line number count

  garray_T lines_ga;                    // keep lines for ":while"/":for"
  ga_init(&lines_ga, (int)sizeof(wcmd_T), 10);

  char_u      *(*cmd_getline)(int, void *, int, bool);
  void        *cmd_cookie;
  struct loop_cookie cmd_loop_cookie;
  LineGetter og_fgetline = fgetline;

  bool getline_is_func_line = getline_equal(fgetline, cookie, get_func_line);

  // Initialize "force_abort"  and "suppress_errthrow" at the top level.
  if (!recursive) {
    force_abort = false;
    suppress_errthrow = false;
  }

  // WIP: Weird
  // struct CmdlineDebugState debug_saved;

  // Get the function or script name and the address where the next breakpoint
  // line and the debug tick for a function or script are stored.
  linenr_T *breakpoint = NULL;          // ptr to breakpoint field in cookie
  int      *dbg_tick = NULL;            // ptr to dbg_tick field in cookie
  char_u   *fname = NULL;               // function or script name
  if (getline_is_func_line) {
    fname = func_name(real_cookie);
    breakpoint = func_breakpoint(real_cookie);
    dbg_tick = func_dbg_tick(real_cookie);
  } else if (getline_equal(fgetline, cookie, getsourceline)) {
    fname = sourcing_name;
    breakpoint = source_breakpoint(real_cookie);
    dbg_tick = source_dbg_tick(real_cookie);
  }

  next_cmdline = cmdline;
  do {
    assert(fgetline == og_fgetline);
    assert(getline_is_func_line == getline_equal(fgetline, cookie, get_func_line));

    getline_is_func_line = getline_equal(fgetline, cookie, get_func_line);

    /* stop skipping cmds for an error msg after all endif/while/for */
    if (next_cmdline == NULL
        && !force_abort
        && cstack->cs_idx < 0
        && !(getline_is_func_line && func_has_abort(real_cookie))) {
      did_emsg = false;
    }

    /*
     * 1. If repeating a line in a loop, get a line from lines_ga.
     * 2. If no line given: Get an allocated line with fgetline().
     * 3. If a line is given: Make a copy, so we can mess with it.
     */

    // 1. If repeating, get a previous line from lines_ga.
    if (cstack->cs_looplevel > 0 && current_line < lines_ga.ga_len) {
      // Each '|' separated command is stored separately in lines_ga, to
      // be able to jump to it.  Don't use next_cmdline now.
      XFREE_CLEAR(cmdline_copy);

      // Check if a function has returned or, unless it has an unclosed
      // try conditional, aborted.
      if (getline_is_func_line) {
        if (do_profiling == PROF_YES) {
          func_line_end(real_cookie);
        }

        if (func_has_ended(real_cookie)) {
          result->retval = FAIL;
          break;
        }
      } else if (do_profiling == PROF_YES
                 && getline_equal(fgetline, cookie, getsourceline)) {
        script_line_end();
      }

      // Check if a sourced file hit a ":finish" command.
      if (source_finished(fgetline, cookie)) {
        result->retval = FAIL;
        break;
      }

      // If breakpoints have been added/deleted need to check for it.
      if (breakpoint != NULL && dbg_tick != NULL
          && *dbg_tick != debug_tick) {
        // TODO(autocmd): Do we have this info already
        *breakpoint = dbg_find_breakpoint(
            getline_equal(fgetline, cookie, getsourceline),
            fname, sourcing_lnum);
        *dbg_tick = debug_tick;
      }

      next_cmdline = ((wcmd_T *)(lines_ga.ga_data))[current_line].line;
      sourcing_lnum = ((wcmd_T *)(lines_ga.ga_data))[current_line].lnum;

      // Did we encounter a breakpoint?
      if (breakpoint != NULL
          && *breakpoint != 0
          && *breakpoint <= sourcing_lnum) {
        dbg_breakpoint(fname, sourcing_lnum);
        // Find next breakpoint.
        *breakpoint = dbg_find_breakpoint(
            getline_equal(fgetline, cookie, getsourceline),
            fname, sourcing_lnum);
        *dbg_tick = debug_tick;
      }
      if (do_profiling == PROF_YES) {
        if (getline_is_func_line) {
          func_line_start(real_cookie);
        } else if (getline_equal(fgetline, cookie, getsourceline)) {
          script_line_start();
        }
      }
    }

    if (cstack->cs_looplevel > 0) {
      // Inside a while/for loop we need to store the lines and use them
      // again.  Pass a different "fgetline" function to do_one_cmd()
      // below, so that it stores lines in or reads them from
      // "lines_ga".  Makes it possible to define a function inside a
      // while/for loop.
      cmd_getline = get_loop_line;
      cmd_cookie = (void *)&cmd_loop_cookie;
      cmd_loop_cookie.lines_gap = &lines_ga;
      cmd_loop_cookie.current_line = current_line;
      cmd_loop_cookie.getline = fgetline;
      cmd_loop_cookie.cookie = cookie;
      cmd_loop_cookie.repeating = (current_line < lines_ga.ga_len);
    } else {
      cmd_getline = fgetline;
      cmd_cookie = cookie;
    }

    // 2. If no line given, get an allocated line with fgetline().
    if (next_cmdline == NULL) {
      // Need to set msg_didout for the first line after an ":if",
      // otherwise the ":if" will be overwritten.
      if (count == 1 && getline_equal(fgetline, cookie, getexline)) {
        msg_didout = true;
      }

      if (fgetline == NULL
          || (next_cmdline = fgetline(':', cookie,
                                      cstack->cs_idx <
                                      0 ? 0 : (cstack->cs_idx + 1) * 2,
                                      true)) == NULL) {
        // Don't call wait_return for aborted command line.  The NULL
        // returned for the end of a sourced file or executed function
        // doesn't do this.
        if (KeyTyped && !(flags & DOCMD_REPEAT)) {
          need_wait_return = false;
        }
        result->retval = FAIL;
        break;
      }
      used_getline = TRUE;

      /*
       * Keep the first typed line.  Clear it when more lines are typed.
       */
      if (flags & DOCMD_KEEPLINE) {
        xfree(repeat_cmdline);
        if (count == 0) {
          repeat_cmdline = vim_strsave(next_cmdline);
        } else {
          repeat_cmdline = NULL;
        }
      }
    }
    /* 3. Make a copy of the command so we can mess with it. */
    else if (cmdline_copy == NULL) {
      next_cmdline = vim_strsave(next_cmdline);
    }
    cmdline_copy = next_cmdline;

    /*
     * Save the current line when inside a ":while" or ":for", and when
     * the command looks like a ":while" or ":for", because we may need it
     * later.  When there is a '|' and another command, it is stored
     * separately, because we need to be able to jump back to it from an
     * :endwhile/:endfor.
     */
    if (current_line == lines_ga.ga_len
        && (cstack->cs_looplevel || has_loop_cmd(next_cmdline))) {
      store_loop_line(&lines_ga, next_cmdline);
    }
    did_endif = false;

    if (count++ == 0) {
      /*
       * All output from the commands is put below each other, without
       * waiting for a return. Don't do this when executing commands
       * from a script or when being called recursive (e.g. for ":e
       * +command file").
       */
      if (!(flags & DOCMD_NOWAIT) && !recursive) {
        result->initial_msg_didout = msg_didout;
        msg_didany = false;         // no output yet
        msg_start();
        msg_scroll = true;          // put messages below each other
        no_wait_return++;           // don't wait for return until finished
        RedrawingDisabled++;
        result->did_inc = true;
      }
    }

    if ((p_verbose >= 15 && sourcing_name != NULL) || p_verbose >= 16) {
      msg_verbose_cmd(sourcing_lnum, cmdline_copy);
    }

    /*
     * 2. Execute one '|' separated command.
     *    do_one_cmd() will return NULL if there is no trailing '|'.
     *    "cmdline_copy" can change, e.g. for '%' and '#' expansion.
     */
    recursive++;

    next_cmdline = do_one_cmd(
        &cmdline_copy,
        flags,
        cstack,
        cmd_getline,
        cmd_cookie);

    recursive--;


    // Ignore trailing '|'-separated commands in preview-mode ('inccommand').
    if (State & CMDPREVIEW) {
      next_cmdline = NULL;
    }

    if (cmd_cookie == (void *)&cmd_loop_cookie) {
      // Use "current_line" from "cmd_loop_cookie", it may have been
      // incremented when defining a function.
      current_line = cmd_loop_cookie.current_line;
    }

    if (next_cmdline == NULL) {
      XFREE_CLEAR(cmdline_copy);

      // If the command was typed, remember it for the ':' register.
      // Do this AFTER executing the command to make :@: work.
      if (ctx->line_type == GETLINE_EX && new_last_cmdline != NULL) {
        xfree(last_cmdline);
        last_cmdline = new_last_cmdline;
        new_last_cmdline = NULL;
      }
    } else {
      // need to copy the command after the '|' to cmdline_copy,
      // for the next do_one_cmd()
      STRMOVE(cmdline_copy, next_cmdline);
      next_cmdline = cmdline_copy;
    }


    // reset did_emsg for a function that is not aborted by an error
    if (did_emsg && !force_abort
        && ctx->line_type == GETLINE_FUNC
        && !func_has_abort(real_cookie)) {
      did_emsg = false;
    }

    if (cstack->cs_looplevel > 0) {
      current_line++;

      /*
       * An ":endwhile", ":endfor" and ":continue" is handled here.
       * If we were executing commands, jump back to the ":while" or
       * ":for".
       * If we were not executing commands, decrement cs_looplevel.
       */
      if (cstack->cs_lflags & (CSL_HAD_CONT | CSL_HAD_ENDLOOP)) {
        cstack->cs_lflags &= ~(CSL_HAD_CONT | CSL_HAD_ENDLOOP);

        /* Jump back to the matching ":while" or ":for".  Be careful
         * not to use a cs_line[] from an entry that isn't a ":while"
         * or ":for": It would make "current_line" invalid and can
         * cause a crash. */
        if (!did_emsg && !got_int && !current_exception
            && cstack->cs_idx >= 0
            && (cstack->cs_flags[cstack->cs_idx]
                & (CSF_WHILE | CSF_FOR))
            && cstack->cs_line[cstack->cs_idx] >= 0
            && (cstack->cs_flags[cstack->cs_idx] & CSF_ACTIVE)) {
          current_line = cstack->cs_line[cstack->cs_idx];
          // remember we jumped there
          cstack->cs_lflags |= CSL_HAD_LOOP;
          line_breakcheck();                    // check if CTRL-C typed

          // Check for the next breakpoint at or after the ":while"
          // or ":for".
          if (breakpoint != NULL) {
            *breakpoint = dbg_find_breakpoint(
                getline_equal(fgetline, cookie, getsourceline),
                fname,
                ((wcmd_T *)lines_ga.ga_data)[current_line].lnum-1);
            *dbg_tick = debug_tick;
          }
        } else {
          // can only get here with ":endwhile" or ":endfor"
          if (cstack->cs_idx >= 0) {
            rewind_conditionals(
                cstack,
                cstack->cs_idx - 1,
                CSF_WHILE | CSF_FOR,
                &(cstack->cs_looplevel));
          }
        }
      } else if (cstack->cs_lflags & CSL_HAD_LOOP) {
        // For a ":while" or ":for" we need to remember the line number.
        cstack->cs_lflags &= ~CSL_HAD_LOOP;
        cstack->cs_line[cstack->cs_idx] = current_line - 1;
      }
    }

    // When not inside any ":while" loop, clear remembered lines.
    if (cstack->cs_looplevel == 0) {
      if (!GA_EMPTY(&lines_ga)) {
        sourcing_lnum = ((wcmd_T *)lines_ga.ga_data)[lines_ga.ga_len - 1].lnum;
        GA_DEEP_CLEAR(&lines_ga, wcmd_T, FREE_WCMD);
      }
      current_line = 0;
    }

    // A ":finally" makes did_emsg, got_int and current_exception pending for
    // being restored at the ":endtry".  Reset them here and set the
    // ACTIVE and FINALLY flags, so that the finally clause gets executed.
    // This includes the case where a missing ":endif", ":endwhile" or
    // ":endfor" was detected by the ":finally" itself.
    if (cstack->cs_lflags & CSL_HAD_FINA) {
      cstack->cs_lflags &= ~CSL_HAD_FINA;
      report_make_pending((cstack->cs_pending[cstack->cs_idx]
                           & (CSTP_ERROR | CSTP_INTERRUPT | CSTP_THROW)),
                          current_exception);
      did_emsg = got_int = false;
      current_exception = NULL;
      cstack->cs_flags[cstack->cs_idx] |= CSF_ACTIVE | CSF_FINALLY;
    }

    // Update global "trylevel" for recursive calls to do_cmdline() from
    // within this loop.
    trylevel = ctx->initial_trylevel + cstack->cs_trylevel;

    // If the outermost try conditional (across function calls and sourced
    // files) is aborted because of an error, an interrupt, or an uncaught
    // exception, cancel everything.  If it is left normally, reset
    // force_abort to get the non-EH compatible abortion behavior for
    // the rest of the script.
    if (trylevel == 0 && !did_emsg && !got_int && !current_exception) {
      force_abort = false;
    }

    // Convert an interrupt to an exception if appropriate.
    (void)do_intthrow(cstack);
  // Continue executing command lines when:
  // - no CTRL-C typed, no aborting error, no exception thrown or try
  //   conditionals need to be checked for executing finally clauses or
  //   catching an interrupt exception
  // - didn't get an error message or lines are not typed
  // - there is a command after '|', inside a :if, :while, :for or :try, or
  //   looping for ":source" command or function call.
  } while (!((got_int || (did_emsg && force_abort) || current_exception)
             && cstack->cs_trylevel == 0)
           && !(did_emsg
                // Keep going when inside try/catch, so that the error can be
                // deal with, except when it is a syntax error, it may cause
                // the :endtry to be missed.
                && (cstack->cs_trylevel == 0 || did_emsg_syntax)
                && used_getline
                && (ctx->line_type == GETLINE_EX_MODE
                    || ctx->line_type == GETLINE_EX))
           && (next_cmdline != NULL
               || cstack->cs_idx >= 0
               || (flags & DOCMD_REPEAT)));


  xfree(cmdline_copy);
  GA_DEEP_CLEAR(&lines_ga, wcmd_T, FREE_WCMD);

  return result;
}
