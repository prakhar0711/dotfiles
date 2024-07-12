" Clear all existing highlights
highlight clear

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = empty(a:bg) ? '' : 'guibg=' . a:bg
  if !empty(bg)
    let bg .= ' guifg=' . s:Color0
  endif
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg . ' ' . gui
endfunction

" Define colors
let s:Color0 = '#ebdbb0'
let s:Color1 = '#f92672'
let s:Color2 = '#00bcaf'
let s:Color3 = '#009489'
let s:Color4 = '#B7F3DB'
let s:Color5 = '#91f697'
let s:Color6 = '#95fff8'
let s:Color7 = '#DBA5C8'
let s:Color8 = '#b7f3db'
let s:Color9 = '#232627'
" to add transparency add 80 @ end of below colour
let s:Color10 = '#1d2021'
let s:Color11 = '#363e2b'
let s:Color12 = '#4a191a'
let s:Color13 = '#3d3e38'
let s:Color14 = '#6f6b5b'

" Apply highlights using the defined function
call s:highlight('Normal', s:Color10,s:Color8 , 'italic')
call s:highlight('Operator', '', s:Color1, '')
call s:highlight('Keyword', '', s:Color1, 'italic')
call s:highlight('TSNamespace', '', s:Color0, '')
call s:highlight('Identifier', '', s:Color2, '')
call s:highlight('Function', '', s:Color3, 'italic')
call s:highlight('Type', '', s:Color5, '')
call s:highlight('StorageClass', '', s:Color0, '')
call s:highlight('Conditional', '', s:Color0, 'italic')
call s:highlight('Repeat', '', s:Color0, '')
call s:highlight('Structure', '', s:Color2, '')
call s:highlight('String', '', s:Color5, 'italic')
call s:highlight('Number', '', s:Color7, '')
call s:highlight('Constant', '', s:Color8, '')
call s:highlight('Comment', '', '', 'italic')

" lualine colours
call s:highlight('StatusLine', s:Color9, s:Color1, '')
call s:highlight('WildMenu', s:Color10, s:Color0, '')
"
" " popupmenu colours
call s:highlight('Pmenu', s:Color1, s:Color0, '')
" call s:highlight('NoiceCmdlinePopup', s:Color1, s:Color0, '')
call s:highlight('PmenuSel', s:Color0, s:Color10, '')
call s:highlight('PmenuThumb', s:Color10, s:Color0, '')
call s:highlight('DiffAdd', s:Color11, '', '')
call s:highlight('DiffDelete', s:Color12, '', '')
call s:highlight('NoicePopupmenuBorder', s:Color3, s:Color0, '')
" visual mode colours
call s:highlight('Visual', s:Color13, '', '')

" line where cursor is positioned
call s:highlight('CursorLine', '', '', 'none')

" column where the cursor is positioned
call s:highlight('ColorColumn', s:Color13, '', '')

" column where signs are displayed
call s:highlight('SignColumn', s:Color10, '', '')

" line numbers
call s:highlight('LineNr', '', s:Color14, '')

" Tab Bar
call s:highlight('TabLine', s:Color9, s:Color14, '')
call s:highlight('TabLineSel', s:Color1, s:Color10, 'bold')
call s:highlight('TabLineFill', s:Color9, s:Color14, '')
call s:highlight('TSPunctDelimiter', '', s:Color0, '')

" Additional highlight groups
call s:highlight('Conceal', '', s:Color7, 'bold')

" currently searched text
call s:highlight('CurSearch', s:Color0, s:Color1, 'bold')

" cursor itself
" call s:highlight('Cursor', s:Color0, s:Color10, '')
call s:highlight('CursorColumn', '', s:Color13, '')
call s:highlight('Directory', '', s:Color3, '')
call s:highlight('DiffChange', s:Color12, '', '')
call s:highlight('DiffText', '', s:Color13, '')
call s:highlight('EndOfBuffer', '', s:Color0, '')
call s:highlight('ErrorMsg', '', s:Color1, '')

" window separator
call s:highlight('WinSeparator', s:Color10,s:Color11 , '')

" vertical window separator
call s:highlight('VertSplit', s:Color9, '', '')

" Folded text
call s:highlight('Folded', s:Color5, s:Color10, '')
call s:highlight('FoldColumn', s:Color9, s:Color14, '')

" highlighting during incremental search
call s:highlight('IncSearch', s:Color1, s:Color13, '')

" text being replaced during substitution
call s:highlight('Substitute', s:Color8, s:Color12, '')

" line number and column number of the cursor position
call s:highlight('CursorLineNr', s:Color1, s:Color13, 'bold')

" matching parenthesis
call s:highlight('MatchParen', s:Color1, s:Color13, 'bold')

" mode indicator msg in the status line
call s:highlight('ModeMsg', s:Color1, s:Color13, 'bold')

call s:highlight('MsgArea', '', s:Color1, '')
call s:highlight('MsgSeparator', '', s:Color13, '')
call s:highlight('MoreMsg', '', s:Color3, '')
call s:highlight('NonText', '', s:Color13, '')

" floating window in normal mode
call s:highlight('NormalFloat', s:Color10, s:Color0, '')
call s:highlight('FloatBorder', s:Color10, s:Color1, '')
call s:highlight('FloatTitle', s:Color13, s:Color9, 'bold')
call s:highlight('FloatFooter', s:Color13, s:Color10, '')
call s:highlight('NormalNC', s:Color10, s:Color0, 'none')
call s:highlight('PmenuKind', s:Color11, s:Color10, '')
call s:highlight('PmenuKindSel', s:Color14, s:Color0, '')
call s:highlight('PmenuExtra', s:Color7, s:Color10, '')
call s:highlight('PmenuExtraSel', s:Color7, s:Color0, '')
call s:highlight('PmenuSbar', s:Color2, s:Color0, '')
call s:highlight('Question', '', s:Color3, '')
call s:highlight('QuickFixLine', s:Color10, s:Color0, '')

" search pattern highlighting
call s:highlight('Search', s:Color1, s:Color13, '')

" special keys displayed in the status line
call s:highlight('SpecialKey', '', s:Color13, '')
call s:highlight('SpellBad', '', s:Color1, '')
call s:highlight('SpellCap', '', s:Color3, '')
call s:highlight('SpellLocal', '', s:Color3, '')
call s:highlight('SpellRare', '', s:Color3, '')
call s:highlight('StatusLineNC', s:Color13, s:Color9, '')

" title
call s:highlight('Title', '', s:Color6, 'bold')
call s:highlight('VisualNOS', s:Color13, '', '')
call s:highlight('WarningMsg', '', s:Color3, '')
call s:highlight('Whitespace', '', s:Color13, '')
call s:highlight('Winbar', '', s:Color14, '')
call s:highlight('WinbarNC', '', s:Color14, '')
call s:highlight('debugPC', s:Color12, '', '')
call s:highlight('debugBreakpoint', s:Color1, s:Color13, '')
call s:highlight('LspReferenceText', s:Color3, '', '')
call s:highlight('LspReferenceRead',s:Color3 ,'' , '')
" call s:highlight('LspReferenceWrite', s:Color3, '', 'bold')

" Links for plugins
highlight! link TelescopeNormal Normal
highlight! link NonText Comment
highlight! link TSProperty TSField
highlight! link TSPunctBracket MyTag
highlight! link TSNamespace TSType
highlight! link TSField Constant
highlight! link TSPunctSpecial TSPunctDelimiter
highlight! link TSLabel Type
highlight! link TSFuncMacro Macro
highlight! link TSConstant Constant
highlight! link TSKeyword Keyword
highlight! link Folded Comment
highlight! link Macro Function
highlight! link Conditional Operator
highlight! link TSTagDelimiter Type
highlight! link TSFunction Function
highlight! link TSParameterReference TSParameter
highlight! link TSConditional Conditional
highlight! link TSTag MyTag
highlight! link TSRepeat Repeat
highlight! link TSNumber Number
highlight! link CursorLineNr Identifier
highlight! link Repeat Conditional
highlight! link Whitespace Comment
highlight! link TSComment Comment
highlight! link TSType Type
highlight! link TSConstBuiltin TSVariableBuiltin
highlight! link TSParameter Constant
highlight! link TSOperator Operator
highlight! link TSString String
highlight! link TSFloat Number

" Add these highlight links to your existing color scheme

" Git and VCS related highlights
call s:highlight('GitSignsAdd', s:Color5, s:Color10, '')
call s:highlight('GitSignsChange', s:Color7, s:Color10, '')
call s:highlight('GitSignsDelete', s:Color1, s:Color10, '')

" Neogit highlights
call s:highlight('NeogitDiffContextHighlight', '', s:Color13, '')
call s:highlight('NeogitHunkHeader', '', s:Color3, '')
call s:highlight('NeogitHunkHeaderHighlight', s:Color8, s:Color13, '')
call s:highlight('NeogitDiffAddHighlight', '', s:Color11, '')
call s:highlight('NeogitDiffDeleteHighlight', '', s:Color12, '')

" TreeSitter highlights
highlight! link TreesitterContext Folded
call s:highlight('TreesitterContextLineNumber', s:Color6, s:Color10, '')

" Notify highlights
call s:highlight('NotifyBackground', '', s:Color10, '')
highlight! link NotifyERRORBorder DiagnosticError
highlight! link NotifyWARNBorder DiagnosticWarn
highlight! link NotifyINFOBorder DiagnosticInfo
highlight! link NotifyHINTBorder DiagnosticHint
highlight! link NotifyDEBUGBorder Debug
highlight! link NotifyTRACEBorder Comment
highlight! link NotifyERRORIcon DiagnosticError
highlight! link NotifyWARNIcon DiagnosticWarn
highlight! link NotifyINFOIcon DiagnosticInfo
highlight! link NotifyHINTIcon DiagnosticHint
highlight! link NotifyDEBUGIcon Debug
highlight! link NotifyTRACEIcon Comment
highlight! link NotifyERRORTitle DiagnosticError
highlight! link NotifyWARNTitle DiagnosticWarn
highlight! link NotifyINFOTitle DiagnosticInfo
highlight! link NotifyHINTTitle DiagnosticHint
highlight! link NotifyDEBUGTitle Debug
highlight! link NotifyTRACETitle Comment

" Dap-UI highlights
highlight! link DapUIScope Special
highlight! link DapUIType Type
call s:highlight('DapUIModifiedValue', s:Color6, '', 'bold')
call s:highlight('DapUIDecoration', s:Color0, '', '')
call s:highlight('DapUIThread', s:Color2, '', '')
call s:highlight('DapUIStoppedThread', s:Color6, '', '')
call s:highlight('DapUISource', s:Color8, '', '')
call s:highlight('DapUILineNumber', s:Color6, '', '')
call s:highlight('DapUIFloatBorder', s:Color0, '', '')
call s:highlight('DapUIWatchesEmpty', s:Color1, '', '')
call s:highlight('DapUIWatchesValue', s:Color2, '', '')
call s:highlight('DapUIWatchesError', s:Color1, '', '')
highlight! link DapUIBreakpointsPath Directory
call s:highlight('DapUIBreakpointsInfo', s:Color4, '', '')
call s:highlight('DapUIBreakpointsCurrentLine', s:Color2, '', 'bold')
highlight! link DapUIBreakpointsDisabledLine Comment
call s:highlight('DapUIStepOver', s:Color6, '', '')
call s:highlight('DapUIStepInto', s:Color6, '', '')
call s:highlight('DapUIStepBack', s:Color6, '', '')
call s:highlight('DapUIStepOut', s:Color6, '', '')
call s:highlight('DapUIStop', s:Color1, '', '')
call s:highlight('DapUIPlayPause', s:Color5, '', '')
call s:highlight('DapUIRestart', s:Color5, '', '')
call s:highlight('DapUIUnavailable', s:Color14, '', '')

" Floaterm highlights
call s:highlight('FloatermBorder', s:Color0, s:Color10, '')

" Health highlights
call s:highlight('healthError', s:Color1, '', '')
call s:highlight('healthSuccess', s:Color5, '', '')
call s:highlight('healthWarning', s:Color3, '', '')

" Lazy highlights
call s:highlight('LazyProgressTodo','' , s:Color13, '')

" Trouble highlights
call s:highlight('TroubleIndent', s:Color14, '', '')
call s:highlight('TroublePos', s:Color6, '', '')

" Nvim-Navic highlights
highlight! link NavicIconsFile Directory
highlight! link NavicIconsModule @module
highlight! link NavicIconsNamespace @module
highlight! link NavicIconsPackage @module
highlight! link NavicIconsClass Type
highlight! link NavicIconsMethod @function.method
highlight! link NavicIconsProperty @property
highlight! link NavicIconsField @variable.member
highlight! link NavicIconsConstructor @constructor
highlight! link NavicIconsEnum Type
highlight! link NavicIconsInterface Type
highlight! link NavicIconsFunction Function
highlight! link NavicIconsVariable @variable
highlight! link NavicIconsConstant Constant
highlight! link NavicIconsString String
highlight! link NavicIconsNumber Number
highlight! link NavicIconsBoolean Boolean
highlight! link NavicIconsArray Type
highlight! link NavicIconsObject Type
highlight! link NavicIconsKey Identifier
highlight! link NavicIconsNull Type
highlight! link NavicIconsEnumMember Constant
highlight! link NavicIconsStruct Structure
highlight! link NavicIconsEvent Structure
highlight! link NavicIconsOperator Operator
highlight! link NavicIconsTypeParameter Type
call s:highlight('NavicText', s:Color0, '', '')
call s:highlight('NavicSeparator', s:Color0, '', '')

" Aerial icons (same as Nvim-Navic)
highlight! link AerialFileIcon Directory
highlight! link AerialModuleIcon @module
highlight! link AerialNamespaceIcon @module
highlight! link AerialPackageIcon @module
highlight! link AerialClassIcon Type
highlight! link AerialMethodIcon @function.method
highlight! link AerialPropertyIcon @property
highlight! link AerialFieldIcon @variable.member
highlight! link AerialConstructorIcon @constructor
highlight! link AerialEnumIcon Type
highlight! link AerialInterfaceIcon Type
highlight! link AerialFunctionIcon Function
highlight! link AerialVariableIcon @variable
highlight! link AerialConstantIcon Constant
highlight! link AerialStringIcon String
highlight! link AerialNumberIcon Number
highlight! link AerialBooleanIcon Boolean
highlight! link AerialArrayIcon Type
highlight! link AerialObjectIcon Type
highlight! link AerialKeyIcon Identifier
highlight! link AerialNullIcon Type
highlight! link AerialEnumMemberIcon Constant
highlight! link AerialStructIcon Structure
highlight! link AerialEventIcon Structure
highlight! link AerialOperatorIcon Operator
highlight! link AerialTypeParameterIcon Type

highlight! link TelescopeResultsField @field
highlight! link TelescopeResultsVariable @variable

" Telescope highlights
call s:highlight('TelescopeBorder', s:Color9, s:Color9, 'none')
call s:highlight('TelescopeTitle', s:Color9, s:Color9, 'bold')
call s:highlight('TelescopeNormal', s:Color10, s:Color8, '')
call s:highlight('TelescopePromptPrefix', s:Color10, s:Color1, '')
call s:highlight('TelescopePromptNormal', s:Color10, s:Color8, '')
call s:highlight('TelescopePromptBorder', s:Color9, s:Color9, '')
call s:highlight('TelescopeSelection', s:Color13, s:Color0, 'none')
call s:highlight('TelescopeSelectionCaret', s:Color10, s:Color1, '')
call s:highlight('TelescopeMultiSelection', s:Color10, s:Color1, '')
call s:highlight('TelescopeMatching', s:Color3, s:Color10, 'bold')
call s:highlight('TelescopePreviewTitle', s:Color9, s:Color1, 'bold')
call s:highlight('TelescopePromptTitle', s:Color9, s:Color1, 'bold')
call s:highlight('TelescopeResultsTitle', s:Color9, s:Color1, 'bold')
call s:highlight('TelescopeResultsClass', s:Color10, s:Color6, '')
call s:highlight('TelescopeResultsStruct', s:Color10, s:Color6, '')
call s:highlight('TelescopeResultsField', s:Color10, s:Color8, 'none')
call s:highlight('TelescopeResultsMethod', s:Color10, s:Color3, 'italic')
call s:highlight('TelescopeResultsVariable', s:Color10, s:Color8, 'none')

" Text within the completion menu items
call s:highlight('CmpItemAbbr', '', s:Color2, '')        
call s:highlight('CmpItemAbbrDeprecated', '', s:Color1, '') 
call s:highlight('CmpItemAbbrMatch', '', s:Color1, '')    
call s:highlight('CmpItemAbbrMatchFuzzy', '', s:Color8, '') 
call s:highlight('CmpItemKindDefault', '', s:Color14, '')   
call s:highlight('CmpItemMenu', '', s:Color2, '')      
call s:highlight('CmpItemKindText', '', s:Color2, '')    
call s:highlight('CmpItemKindMethod', '', s:Color3, '')   
call s:highlight('CmpItemKindFunction', '', s:Color4, '')    
call s:highlight('CmpItemKindConstructor', '', s:Color5, '') 
call s:highlight('CmpItemKindField', '', s:Color6, '')    
call s:highlight('CmpItemKindVariable', '', s:Color7, '')    
call s:highlight('CmpItemKindClass', '', s:Color8, '')   
call s:highlight('CmpItemKindInterface', '', s:Color1, '') 
call s:highlight('CmpItemKindModule', '', s:Color2, '')  
call s:highlight('CmpItemKindProperty', '', s:Color0, '')  
call s:highlight('CmpItemKindKeyword', '', s:Color1, '')  
call s:highlight('CmpItemKindUnit', '', s:Color2, '')  
call s:highlight('CmpItemKindValue', '', s:Color3, '')  
call s:highlight('CmpItemKindEnum', '', s:Color4, '')  
call s:highlight('CmpItemKindSnippet', '', s:Color5, '')  
call s:highlight('CmpItemKindColor', '', s:Color6, '')  
call s:highlight('CmpItemKindFile', '', s:Color7, '')  
call s:highlight('CmpItemKindReference', '', s:Color8, '')  
call s:highlight('CmpItemKindFolder', '', s:Color0, '')  
call s:highlight('CmpItemKindEnumMember', '', s:Color1, '')  
call s:highlight('CmpItemKindConstant', '', s:Color2, '')  
call s:highlight('CmpItemKindStruct', '', s:Color3, '')  
call s:highlight('CmpItemKindEvent', '', s:Color4, '')  
call s:highlight('CmpItemKindOperator', '', s:Color5, '')  
call s:highlight('CmpItemKindTypeParameter', '', s:Color6, '')  
call s:highlight('CmpItemKindCopilot', '', s:Color7, '')  
call s:highlight('CmpItemKindCodeium', '', s:Color8, '')  
" call s:highlight('CmpCompletionBorder', s:Color5, '', '')
" call s:highlight('CmpCompletionThumb', s:Color6, s:Color3, '') 
" call s:highlight('CmpCompletionSbar', s:Color8, s:Color7, '') 



