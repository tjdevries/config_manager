local Job = require "plenary.job"

local scripts = {}

scripts.install = {}

scripts.install.src_cli = function()
  Job
    :new({
      "curl",
      "-L",
      "https://sourcegraph.com/.api/src-cli/src_linux_amd64",
      "-o",
      vim.fn.expand "~/.local/bin/src",
    })
    :sync()

  Job
    :new({
      "chmod",
      "+x",
      vim.fn.expand "~/.local/bin/src",
    })
    :sync()
end

return scripts
