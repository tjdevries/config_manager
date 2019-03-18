let baz = {'a': "A"}

call assert_equal(baz, nvim_get_var('baz'), 'this will not error')
call assert_equal(baz.a, 'A', 'this will not error')

call nvim_set_var('baz', {'a': "B"})
call assert_equal(baz.a, 'B', 'this will not error')

let baz = {'a': "A"}
call nvim_set_var('baz.a', 'B')
call assert_equal(baz.a, 'A', 'this will not error')

call assert_equal(nvim_get_var('baz.a'), 'B', 'this will not error')
echo nvim_get_var('baz.a')
