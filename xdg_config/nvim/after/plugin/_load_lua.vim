let s:load_dir = expand('<sfile>:p:h:h:h')
exec printf('luafile %s/lua/init.lua', s:load_dir)
