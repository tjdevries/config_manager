
local has_plenary, Job = pcall(require, 'plenary.job')
if not has_plenary then
  Job = require('tj._job')
end

vim.cmd [[botright 25 new]]
local new_buffer = vim.api.nvim_get_current_buf()
vim.api.nvim_buf_set_option(new_buffer, 'bufhidden', 'wipe')
vim.api.nvim_buf_set_option(new_buffer, 'buftype', 'nofile')
vim.api.nvim_buf_set_keymap(new_buffer, 'n', '<CR>', ':bw!<CR>', {noremap = true})

local completed = 0
local started = 0

local update_status = function()
  vim.api.nvim_buf_set_lines(new_buffer, 1, 2, false, { string.format("%s / %s", completed, started) })
end

local update_entry = function(entry, line)
  local row = entry + 1

  while vim.api.nvim_buf_line_count(new_buffer) < row do
    vim.api.nvim_buf_set_lines(new_buffer, -1, -1, false, { "" })
  end

  vim.api.nvim_buf_set_lines(new_buffer, row, row + 1, false, { line })
end

local sourcegraph_repos = {
  -- Need to do git credentials for this to work.
  -- "sourcegraph/dev-private",

  "sourcegraph/src-cli",
  "sourcegraph/lsif-go",
  "sourcegraph/sourcegraph",
  "sourcegraph/lsif-clang",
}

local plugin_repos = {
  ["tjdevries"] = {
    "colorbuddy.nvim",
    "gruvbuddy.nvim",
    "green_light.nvim",
    "rofl.nvim",
    "telescope-hacks.nvim",
    "telescope-sourcegraph.nvim",
    "tree-sitter-lua",
    "tree-sitter-sql",
    "vim9jit",
  },

  ["nvim-telescope"] = {
    "telescope.nvim",
    "telescope-fzf-writer.nvim",
  },

  ["nvim-lua"] = {
    "plenary.nvim",
    "popup.nvim",
  },
}

local build_repos = {
  -- Neovim
  "neovim/neovim",

  -- Rust analyzer
  "rust-analyzer/rust-analyzer",

  -- Delta
  "dandavison/delta",

  -- toggle's cool typing test
  "togglebyte/toggle_cool_cow_says_type",
}

local testing = false

local create_github_repo = function(repo, root)
  if testing then
    root = vim.fn.expand("~/test-sourcegraph/")
  end

  -- TODO: Should make base directories here?
  Job:new { "mkdir", "-p", vim.fn.expand(root) }:sync()

  local split_name = vim.split(repo, "/", true)
  local dest_name = vim.fn.expand(root .. split_name[2])
  if vim.fn.isdirectory(dest_name) == 1 then
    return
  end

  local id = started

  return Job:new {
    "git",  "clone", string.format("https://github.com/%s", repo), dest_name,

    interactive = false,

    on_start = function()
      started = started + 1
      update_entry(id, "Started  : " .. root .. " " .. repo)
    end,

    on_exit = vim.schedule_wrap(function()
      completed = completed + 1
      update_status()
      update_entry(id, "Completed: " .. root .. " " .. repo)
    end),
  }
end

local function clone_sg_repos()
  local sg_jobs = {}
  for _, repo in ipairs(sourcegraph_repos) do
    local j = create_github_repo(repo, "~/sourcegraph/")
    if j then
      j:start()
      table.insert(sg_jobs, j)
    end
  end

  return sg_jobs
end

local function clone_build_repos()
  local sg_jobs = {}
  for _, repo in ipairs(build_repos) do
    local j = create_github_repo(repo, "~/build/")
    if j then
      j:start()
      table.insert(sg_jobs, j)
    end
  end

  return sg_jobs
end

local function clone_plugin_repos() 
  local plugin_jobs = {}
  for base, plugs in pairs(plugin_repos) do
    for _, plugin in ipairs(plugs) do
      local j = create_github_repo(
        string.format("%s/%s", base, plugin),
        "~/plugins/"
      )

      if j then
        j:start()
        table.insert(plugin_jobs, j)
      end
    end
  end

  return plugin_jobs
end

clone_sg_repos()
clone_build_repos()
clone_plugin_repos()

update_status()
