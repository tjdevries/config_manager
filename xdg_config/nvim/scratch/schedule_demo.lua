print "Starting"

local scheduled_print = vim.schedule_wrap(function()
  print "Whoa, scheduling _IN_ a scheduled function!"
end)

print "Scheduling #1..."
vim.schedule(function()
  print "Message #1"

  scheduled_print()
  scheduled_print()
end)
print "... Done #1"

print "Scheduling #2..."
vim.schedule(function()
  print "Message #2"
end)
print "... Done #2"
