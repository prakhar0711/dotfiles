return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = false,
      theme = "wave",
      colors = {
        palette = {
          --   peachRed = "#CE2C66",
          --   boatYellow2 = "#CE2C66",
          --   springGreen = "#7BCE81",
          --   oniViolet = "#CE2C66",
          --   springBlue = "#0D625B",
          --   crystalBlue = "#009489",
          --   waveRed = "#CE2C66",
          --   springViolet1 = "#F4CE02",
          --   springViolet2 = "#187FC7",
          --   fujiWhite = "#02B4A8",
          --   waveAqua2 = "#ebdbb0",
          --   -- sumiInk0 = "#1d2021", --lazy and mason background
          sumiInk3 = "#151521", --background
        },
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        local blend_value = 0 -- You can adjust this value as needed
        return {
          -- WinSeparator = { fg = "#0d4e7a" },
          -- Normal = { italic = true },
          -- NormalNC = { italic = false }, -- Non-current windows
          -- Comment = { italic = true },
          -- Constant = { italic = true },
          -- String = { italic = true, bold = true },
          -- Identifier = { italic = true },
          -- Function = { italic = true },
          -- Statement = { italic = true },
          -- PreProc = { italic = true, bold = true },
          -- Type = { italic = true },
          -- Special = { italic = true, bold = true },
          -- Operator = { italic = true, bold = true },
          -- Keyword = { italic = true },
          -- Macro = { link = "Function" },
          -- Folded = { link = "Comment" },
          -- Conditional = { link = "Operator" },
          -- Repeat = { link = "Conditional" },
          -- TSKeywordFunction = { link = "Keyword" },
          -- TSProperty = { link = "TSField" },
          -- TSNamespace = { link = "TSType" },
          -- TSField = { link = "Constant" },
          -- TSPunctSpecial = { link = "TSPunctDelimiter" },
          -- TSPunctDelimiter = { italic = true },
          -- TSLabel = { link = "Type" },
          -- TSFuncMacro = { link = "Macro" },
          -- TSConstant = { link = "Constant" },
          -- TSKeyword = { link = "Keyword" },
          -- TSTagDelimiter = { link = "Type" },
          -- TSFunction = { link = "Function" },
          -- TSParameterReference = { link = "TSParameter" },
          -- TSConditional = { link = "Conditional" },
          -- TSTag = { link = "MyTag" },
          -- TSRepeat = { link = "Repeat" },
          -- TSNumber = { link = "Number" },
          -- TSType = { link = "Type" },
          -- TSConstBuiltin = { link = "TSVariableBuiltin" },
          -- TSParameter = { link = "Constant" },
          -- TSOperator = { link = "Operator" },
          -- TSString = { link = "String" },
          -- TSFloat = { link = "Number" },
          -- NormalFloat = { bg = "none", blend = blend_value },
          -- FloatBorder = { bg = "none", fg = "#187fc7", blend = blend_value },
          -- FloatTitle = { bg = "none", blend = blend_value },
          --
          -- nvim-cmp specific highlights
          CmpItemAbbr = { bg = "none", fg = theme.ui.fg, blend = blend_value },
          CmpItemAbbrMatch = { bg = "none", fg = "#CE2C66", bold = true, blend = blend_value },
          CmpItemMenu = { bg = "none", fg = "#187FC7", blend = blend_value },
          CmpItemAbbrDeprecated = { bg = "none", fg = theme.ui.fg_dim, strikethrough = true, blend = blend_value },
          CmpCompletion = { bg = "none", link = "Pmenu", blend = blend_value },
          CmpCompletionSel = { bg = "none", fg = "none", blend = blend_value },
          CmpCompletionBorder = { bg = "none", fg = theme.ui.bg_search, blend = blend_value },
          CmpCompletionThumb = { bg = "none", link = "PmenuThumb", blend = blend_value },
          CmpCompletionSbar = { bg = "none", link = "PmenuSbar", blend = blend_value },
          CmpItemAbbrMatchFuzzy = { bg = "none", link = "CmpItemAbbrMatch", italic = true, blend = blend_value },
          --
          -- Telescope specific highlights
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
}
