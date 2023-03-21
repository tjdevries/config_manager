return {
  {
    "Eandrju/cellular-automaton.nvim",
    config = function()
      require("cellular-automaton").register_animation {
        fps = 50,
        name = "slide",
        update = function(grid)
          for i = 1, #grid do
            local prev = grid[i][#grid[i]]
            for j = 1, #grid[i] do
              grid[i][j], prev = prev, grid[i][j]
            end
          end
          return true
        end,
      }

      require("cellular-automaton").register_animation {
        fps = 30,
        name = "scramble",

        update = function(grid)
          local function is_alphanumeric(c)
            return c >= "a" and c <= "z" or c >= "A" and c <= "Z" or c >= "0" and c <= "9"
          end

          local scramble_word = function(word)
            local chars = {}
            while #word ~= 0 do
              local index = math.random(1, #word)
              table.insert(chars, word[index])
              table.remove(word, index)
            end
            return chars
          end
          for i = 1, #grid do
            local scrambled = {}
            local word = {}
            for j = 1, #grid[i] do
              local c = grid[i][j]
              if not is_alphanumeric(c.char) then
                if #word ~= 0 then
                  for _, d in pairs(scramble_word(word)) do
                    table.insert(scrambled, d)
                  end
                  word = {}
                end
                table.insert(scrambled, c)
              else
                table.insert(word, c)
              end
            end

            grid[i] = scrambled
          end
          return true
        end,
      }

      local screensaver = function(grid, swapper)
        local get_character_cols = function(row)
          local cols = {}
          for i = 1, #row do
            if row[i].char ~= " " then
              table.insert(cols, i)
            end
          end

          return cols
        end

        for i = 1, #grid do
          local cols = get_character_cols(grid[i])
          if #cols > 0 then
            local last_col = cols[#cols]
            local prev = grid[i][last_col]
            for _, j in ipairs(cols) do
              prev = swapper(prev, i, j)
            end
          end
        end
      end

      require("cellular-automaton").register_animation {
        fps = 50,
        name = "screensaver",
        update = function(grid)
          screensaver(grid, function(prev, i, j)
            grid[i][j], prev = prev, grid[i][j]
            return prev
          end)

          return true
        end,
      }

      require("cellular-automaton").register_animation {
        fps = 50,
        name = "screensaver-inplace-hl",
        update = function(grid)
          screensaver(grid, function(prev, i, j)
            grid[i][j].char, prev.char = prev.char, grid[i][j].char
            return prev
          end)

          return true
        end,
      }

      require("cellular-automaton").register_animation {
        fps = 50,
        name = "screensaver-inplace-char",
        update = function(grid)
          screensaver(grid, function(prev, i, j)
            grid[i][j].hl_group, prev.hl_group = prev.hl_group, grid[i][j].hl_group
            return prev
          end)
          return true
        end,
      }
    end,
  },
}
