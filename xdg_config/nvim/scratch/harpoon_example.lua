
-- Setting up different harpoon buffers to run
require('harpoon').setup {
  workspaces = {
    ["$HOME/sourcegraph"] = {
      [1] = { "go", "build", "my_custom_thing" },
      [2] = { "go", "test", },
    },
    ["..."] = { ... },
  },

  projects = {
    ["netflix"] = {
      "./tvui/file_1",
      "./lolomo/file_2",
      ...,
      cwd = "/home/mpaulson/netflix_is_pog/",
    },
    ["harpoon"] = {
      "./lua/harpoon.lua",
      "./plugin/harpoon.vim",
      cwd = "/home/mpaulson/rftm/harpoon",
    },
    [function(filepath)
      if filepath == "hello" then
        return true
      end

      if filepath:find(".*hello.*") then
        return true
      end
    end] = {}
  }
}
