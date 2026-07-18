{ lib, ... }:

let
  inherit (lib.nvim.dag) entryAfter;
in
{
  config.vim = {
    luaConfigRC.activity-notifications = entryAfter [ "theme" ] ''
      -- Notify when text is yanked
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Notify on yank',
        group = vim.api.nvim_create_augroup('notify-yank', { clear = true }),
        callback = function()
          if vim.v.event.operator == 'y' then
            local regcontents = vim.v.event.regcontents
            local num_lines = #regcontents
            local yanked_text = table.concat(regcontents, '\n')
            local lines_str = num_lines == 1 and "1 line" or tostring(num_lines) .. " lines"
            
            -- Truncate content for a neat preview in the notification
            local preview = yanked_text
            if #preview > 120 then
              preview = string.sub(preview, 1, 117) .. "..."
            end
            preview = preview:gsub("\r", ""):gsub("\n", " ↵ ")
            
            vim.notify(
              string.format("Yanked %s:\n\"%s\"", lines_str, preview),
              vim.log.levels.INFO,
              { title = "Clipboard", icon = "📋", timeout = 1500 }
            )
          end
        end,
      })

      -- Notify when file is saved
      vim.api.nvim_create_autocmd('BufWritePost', {
        desc = 'Notify on save',
        group = vim.api.nvim_create_augroup('notify-save', { clear = true }),
        callback = function(opts)
          local filename = vim.fn.fnamemodify(opts.match, ':t')
          if filename == "" or vim.bo[opts.buf].buftype ~= "" then
            return
          end
          
          local filesize = vim.fn.getfsize(opts.match)
          local size_str = ""
          if filesize >= 1024 * 1024 then
            size_str = string.format("%.2f MB", filesize / (1024 * 1024))
          elseif filesize >= 1024 then
            size_str = string.format("%.2f KB", filesize / 1024)
          elseif filesize >= 0 then
            size_str = tostring(filesize) .. " B"
          end
          
          vim.notify(
            string.format("Saved %s (%s)", filename, size_str),
            vim.log.levels.INFO,
            { title = "File Saved", icon = "💾", timeout = 1500 }
          )
        end,
      })

      -- Notify on macro recording start/stop
      local macro_group = vim.api.nvim_create_augroup('notify-macro', { clear = true })
      vim.api.nvim_create_autocmd('RecordingEnter', {
        desc = 'Notify on macro recording start',
        group = macro_group,
        callback = function()
          local register = vim.fn.reg_recording()
          vim.notify(
            string.format("Recording macro to @%s...", register),
            vim.log.levels.WARN,
            { title = "Macro", icon = "⏺", timeout = 2000 }
          )
        end,
      })

      vim.api.nvim_create_autocmd('RecordingLeave', {
        desc = 'Notify on macro recording stop',
        group = macro_group,
        callback = function()
          vim.notify(
            "Macro recording stopped",
            vim.log.levels.INFO,
            { title = "Macro", icon = "⏹", timeout = 2000 }
          )
        end,
      })
    '';
  };
}
