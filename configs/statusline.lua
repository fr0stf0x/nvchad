-- Modified nvchad minimal configs
return function(modules)
  local fn = vim.fn
  local config = require("core.utils").load_config().ui.statusline
  local sep_style = config.separator_style

  sep_style = (sep_style ~= "round" and sep_style ~= "block") and "block" or sep_style

  local default_sep_icons = {
    round = { left = "", right = "" },
    block = { left = "█", right = "█" },
  }

  local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

  local sep_l = separators["left"]
  local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"

  local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group, sep_r_group)
    return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r_group
  end

  local modes = {
    ["n"] = { "NORMAL", "St_NormalMode" },
    ["no"] = { "NORMAL (no)", "St_NormalMode" },
    ["nov"] = { "NORMAL (nov)", "St_NormalMode" },
    ["noV"] = { "NORMAL (noV)", "St_NormalMode" },
    ["noCTRL-V"] = { "NORMAL", "St_NormalMode" },
    ["niI"] = { "NORMAL i", "St_NormalMode" },
    ["niR"] = { "NORMAL r", "St_NormalMode" },
    ["niV"] = { "NORMAL v", "St_NormalMode" },
    ["nt"] = { "NTERMINAL", "St_NTerminalMode" },
    ["ntT"] = { "NTERMINAL (ntT)", "St_NTerminalMode" },

    ["v"] = { "VISUAL", "St_VisualMode" },
    ["vs"] = { "V-CHAR (Ctrl O)", "St_VisualMode" },
    ["V"] = { "V-LINE", "St_VisualMode" },
    ["Vs"] = { "V-LINE", "St_VisualMode" },
    [""] = { "V-BLOCK", "St_VisualMode" },

    ["i"] = { "INSERT", "St_InsertMode" },
    ["ic"] = { "INSERT (completion)", "St_InsertMode" },
    ["ix"] = { "INSERT completion", "St_InsertMode" },

    ["t"] = { "TERMINAL", "St_TerminalMode" },

    ["R"] = { "REPLACE", "St_ReplaceMode" },
    ["Rc"] = { "REPLACE (Rc)", "St_ReplaceMode" },
    ["Rx"] = { "REPLACEa (Rx)", "St_ReplaceMode" },
    ["Rv"] = { "V-REPLACE", "St_ReplaceMode" },
    ["Rvc"] = { "V-REPLACE (Rvc)", "St_ReplaceMode" },
    ["Rvx"] = { "V-REPLACE (Rvx)", "St_ReplaceMode" },

    ["s"] = { "SELECT", "St_SelectMode" },
    ["S"] = { "S-LINE", "St_SelectMode" },
    [""] = { "S-BLOCK", "St_SelectMode" },
    ["c"] = { "COMMAND", "St_CommandMode" },
    ["cv"] = { "COMMAND", "St_CommandMode" },
    ["ce"] = { "COMMAND", "St_CommandMode" },
    ["r"] = { "PROMPT", "St_ConfirmMode" },
    ["rm"] = { "MORE", "St_ConfirmMode" },
    ["r?"] = { "CONFIRM", "St_ConfirmMode" },
    ["x"] = { "CONFIRM", "St_ConfirmMode" },
    ["!"] = { "SHELL", "St_TerminalMode" },
  }

  modules[1] = (function()
    local m = vim.api.nvim_get_mode().mode
    return "%#" .. modes[m][2] .. "Text#" .. " " .. modes[m][1] .. sep_r
  end)()

  modules[2] = (function()
    local icon = " 󰈚 "

    local filename = (fn.expand "%" == "" and "Empty") or fn.expand "%:F"

    if filename ~= "Empty" then
      local devicons_present, devicons = pcall(require, "nvim-web-devicons")

      if devicons_present then
        local ft_icon = devicons.get_icon(filename)
        icon = (ft_icon ~= nil and ft_icon) or icon
      end
    end

    return gen_block(icon, filename, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#", sep_r)
  end)()

  modules[11] = (function()
    return gen_block("", "%l/%c", "%#St_Pos_sep#", "%#St_Pos_bg#", "%#St_Pos_txt#", " %#ST_EmptySpace#")
  end)()

  -- return {
  --   cursor_position = function()
  --     return gen_block("", "%l/%c", "%#St_Pos_sep#", "%#St_Pos_bg#", "%#St_Pos_txt#", " %#ST_EmptySpace#")
  --   end,
  --   fileInfo = function()
  --     local icon = " 󰈚 "
  --
  --     local filename = (fn.expand "%" == "" and "Empty") or fn.expand "%:F"
  --
  --     if filename ~= "Empty" then
  --       local devicons_present, devicons = pcall(require, "nvim-web-devicons")
  --
  --       if devicons_present then
  --         local ft_icon = devicons.get_icon(filename)
  --         icon = (ft_icon ~= nil and ft_icon) or icon
  --       end
  --     end
  --
  --     return gen_block(icon, filename, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#", sep_r)
  --   end,
  --   mode = function()
  --     local m = vim.api.nvim_get_mode().mode
  --     return "%#" .. modes[m][2] .. "Text#" .. " " .. modes[m][1] .. sep_r
  --   end,
  -- }
end
