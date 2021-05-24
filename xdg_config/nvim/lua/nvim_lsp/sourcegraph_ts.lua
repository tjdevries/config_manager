local configs = require "nvim_lsp/configs"
local util = require "nvim_lsp/util"

configs.sourcegraph_ts = {
  default_config = {
    cmd = { "node", vim.fn.expand "~/build/javascript-typescript-langserver/lib/language-server-stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
  },
  on_new_config = function(new_config)
    local install_info = installer.info()
    if install_info.is_installed then
      if type(new_config.cmd) == "table" then
        -- Try to preserve any additional args from upstream changes.
        new_config.cmd[1] = install_info.binaries[bin_name]
      else
        new_config.cmd = { install_info.binaries[bin_name] }
      end
    end
  end,
  docs = {
    description = [[
https://github.com/theia-ide/typescript-language-server

`typescript-language-server` can be installed via `:LspInstall tsserver` or by yourself with `npm`:
```sh
npm install -g typescript-language-server
```
]],
    default_config = {
      root_dir = [[root_pattern("package.json", "tsconfig.json", ".git")]],
    },
  },
}

-- vim:et ts=2 sw=2
