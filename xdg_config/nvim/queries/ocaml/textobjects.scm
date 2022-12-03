(let_binding
  pattern: (value_name) @function.outer
  (parameter))

(parameter) @parameter.inner

(let_binding
  pattern: (value_name) @function.outer
  body: [(fun_expression) (function_expression)])
