" Some runtime configuration for my configuration plugin

if !get(g:, 'loaded_conf_vim', v:false)
  finish
endif

" I prefer to just echo out the debug info
call conf#runtime#set('runtime', 'debug_buffer', v:false)
