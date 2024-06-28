return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = true,
      theme = "wave",
      functionStyle = { italic = true },
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      colors = {
        palette = {
          peachRed = "#CE2C66",
          boatYellow2 = "#CE2C66",
          springGreen = "#7BCE81",
          oniViolet = "#CE2C66",
          springBlue = "#0D625B",
          crystalBlue = "#009489",
          waveRed = "#CE2C66",
          springViolet1 = "#F4CE02",
          springViolet2 = "#187FC7",
          fujiWhite = "#02B4A8",
          waveAqua2 = "#ebdbb0",
          -- sumiInk0 = "#1d2021", --lazy and mason background
          sumiInk3 = "#1d2021", --background
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
        local blend_value = 50 -- You can adjust this value as needed
        return {
          Normal = { italic = true },
          Keyword = { italic = true },
          Function = { italic = true },
          String = { italic = true },
          Comment = { italic = true },
          TSProperty = { link = "TSField" },
          TSNamespace = { link = "TSType" },
          TSField = { link = "Constant" },
          TSPunctSpecial = { link = "TSPunctDelimiter" },
          TSLabel = { link = "Type" },
          TSFuncMacro = { link = "Macro" },
          TSConstant = { link = "Constant" },
          TSKeyword = { link = "Keyword" },
          Folded = { link = "Comment" },
          Macro = { link = "Function" },
          Conditional = { link = "Operator", italic = true },
          TSTagDelimiter = { link = "Type" },
          TSFunction = { link = "Function" },
          TSParameterReference = { link = "TSParameter" },
          TSConditional = { link = "Conditional" },
          TSTag = { link = "MyTag" },
          TSRepeat = { link = "Repeat" },
          TSNumber = { link = "Number" },
          Repeat = { link = "Conditional" },
          TSType = { link = "Type" },
          TSConstBuiltin = { link = "TSVariableBuiltin" },
          TSParameter = { link = "Constant" },
          TSOperator = { link = "Operator" },
          TSString = { link = "String" },
          TSFloat = { link = "Number" },

          NormalFloat = { bg = "none", blend = blend_value },
          FloatBorder = { bg = "none", fg = "#187fc7", blend = blend_value },
          FloatTitle = { bg = "none", blend = blend_value },

          -- Noice.nvim specific highlights
          NoiceConfirm = { bg = "none" },

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

          -- Telescope specific highlights
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          BufferLineFill = { bg = "none", blend = blend_value },
          BufferLineBackground = { bg = "none", fg = theme.ui.fg_dim },
          BufferLineBufferSelected = { bg = "none", fg = theme.ui.fg, bold = true, italic = true },
          BufferLineBufferVisible = { bg = "none", fg = theme.ui.fg_dim },
          BufferLineSeparator = { fg = theme.ui.bg, bg = "none" },
          BufferLineSeparatorVisible = { fg = theme.ui.bg, bg = "none", blend = blend_value },
          BufferLineSeparatorSelected = { fg = theme.ui.bg, bg = "none", blend = blend_value },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
}
