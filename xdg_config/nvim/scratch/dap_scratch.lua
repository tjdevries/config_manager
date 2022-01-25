local bufnr = 205
local lenses = vim.lsp.codelens.get(bufnr)

local search = "rust-analyzer.debugSingle"
local start_line = 14

if true then
  return
end

--[[
location = {
    targetRange = {
      end = {
        character = 5,
        line = 22
      },
      start = {
        character = 4,
        line = 14
      }
    },
    targetSelectionRange = {
      end = {
        character = 23,
        line = 15
      },
      start = {
        character = 7,
        line = 15
      }
    },
{
    command = {
      arguments = { {
          args = {
            cargoArgs = { "run", "--package", "dap-tester", "--bin", "dap-tester" },
            cargoExtraArgs = {},
            executableArgs = {},
            workspaceRoot = "/home/tjdevries/tmp/dap-tester"
          },
          kind = "cargo",
          label = "run dap-tester",
          location = {
            targetRange = {
              end = {
                character = 1,
                line = 4
              },
              start = {
                character = 0,
                line = 2
              }
            },
            targetSelectionRange = {
              end = {
                character = 7,
                line = 2
              },
              start = {
                character = 3,
                line = 2
              }
            },
            targetUri = "file:///home/tjdevries/tmp/dap-tester/src/main.rs"
          }
        } },
      command = "rust-analyzer.runSingle",
      title = "▶︎ Run "
    },
--]]
local debug = nil
for _, lens in ipairs(lenses) do
  if lens.command and lens.command.command == search then
    if lens.command.arguments and lens.command.arguments[1].location.targetRange.start.line == start_line then
      debug = lens.command
      break
    end
  end
end

if not debug then
  return
end

-- P(debug)

local args = debug.arguments[1].args

local dap_config = {
  name = "Rust tools debug",
  type = "rt_lldb",
  request = "launch",
  program = "cargo",
  args = args.cargoArgs,
  cwd = args.workspaceRoot,
  stopOnEntry = false,
  runInTerminal = false,
}

require("dap").run(dap_config)
