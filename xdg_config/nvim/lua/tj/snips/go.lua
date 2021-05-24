local indent = require("snippets.utils").match_indentation

local go = {}

go.ctx = "ctx context.Context"

go.err = indent [[
if err != nil {
  return$0
}]]

go.mfile = [[
package main

func main() {
	$0
}
]]

go.main = [[
func main() {
	$0
}
]]

go.func = [[
func $1 {
	$0
}
]]

return go
