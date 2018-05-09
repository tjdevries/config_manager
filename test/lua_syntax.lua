

table.foreach({ a = 1, b = 2}, print)


local mytable = {}

mytable.__index = {}
mytable.__unm = {}
mytable.__eq = {}

print(mytable)

