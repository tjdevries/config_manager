
function! StripUnrelatedKeyTokens() abort
  :g/^\(\(.*action_token_id.*\)\@!.\)*$/normal dd
endfunction


