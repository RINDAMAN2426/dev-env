-- colors.lua - Dark theme converted from VSCode color scheme
local M = {}

-- Helper function to set highlight groups
local function highlight(group, colors)
  local cmd = "highlight " .. group
  if colors.fg then cmd = cmd .. " guifg=" .. colors.fg end
  if colors.bg then cmd = cmd .. " guibg=" .. colors.bg end
  if colors.style then cmd = cmd .. " gui=" .. colors.style end
  if colors.sp then cmd = cmd .. " guisp=" .. colors.sp end
  vim.cmd(cmd)
end

function M.setup()
  -- Clear existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  
  vim.o.termguicolors = true
  vim.o.background = "dark"
  
  -- Set LSP semantic tokens priority higher than Treesitter
  -- When LSP loads, it provides more accurate context-aware highlighting
  -- Treesitter: 100, Syntax: 50, Semantic tokens: 125
  vim.highlight.priorities.semantic_tokens = 125
  
  -- Terminal colors
  vim.g.terminal_color_0 = "#414453"
  vim.g.terminal_color_1 = "#e21515"
  vim.g.terminal_color_2 = "#4dbf57"
  vim.g.terminal_color_3 = "#ffc501"
  vim.g.terminal_color_4 = "#128cff"
  vim.g.terminal_color_5 = "#fe7ab2"
  vim.g.terminal_color_6 = "#b181ec"
  vim.g.terminal_color_7 = "#ffffffd8"
  vim.g.terminal_color_8 = "#7f8c98"
  vim.g.terminal_color_9 = "#e21515"
  vim.g.terminal_color_10 = "#4dbf57"
  vim.g.terminal_color_11 = "#ffc501"
  vim.g.terminal_color_12 = "#128cff"
  vim.g.terminal_color_13 = "#fe7ab2"
  vim.g.terminal_color_14 = "#d9baff"
  vim.g.terminal_color_15 = "#ffffff"

  -- Editor colors
  highlight("Normal", { fg = "#ffffffd8", bg = "#232222" })
  highlight("NormalFloat", { fg = "#dedede", bg = "#2c2c2b" })
  highlight("CursorLine", { bg = "#403e3e" })
  highlight("CursorLineNr", { fg = "#ffffffd8", bg = "#403e3e" })
  highlight("LineNr", { fg = "#747478" })
  highlight("Visual", { bg = "#6e6e6e" })
  highlight("VisualNOS", { bg = "#6e6e6e" })
  highlight("Search", { bg = "#6e6e6e80" })
  highlight("IncSearch", { bg = "#6e6e6e80" })
  highlight("CurSearch", { bg = "#6e6e6e" })

  -- UI elements
  highlight("Pmenu", { fg = "#dedede", bg = "#403e3e" })
  highlight("PmenuSel", { fg = "#ebebeb", bg = "#464646" })
  highlight("PmenuSbar", { bg = "#4f4d4d" })
  highlight("PmenuThumb", { bg = "#555555" })
  highlight("StatusLine", { fg = "#b4b3b3", bg = "#403e3e" })
  highlight("StatusLineNC", { fg = "#acacab", bg = "#403e3e" })
  highlight("TabLine", { fg = "#9f9f9e", bg = "#2c2c2b" })
  highlight("TabLineFill", { bg = "#2c2c2b" })
  highlight("TabLineSel", { fg = "#ebebeb", bg = "#403e3e" })
  highlight("VertSplit", { fg = "#3e3c3c", bg = "#3e3c3c" })
  highlight("WinSeparator", { fg = "#3e3c3c" })
  highlight("Folded", { fg = "#777777", bg = "#2c2c2b" })
  highlight("FoldColumn", { fg = "#747478", bg = "#232222" })
  highlight("SignColumn", { bg = "#232222" })
  highlight("ColorColumn", { bg = "#403e3e" })

  -- Gutter
  highlight("DiffAdd", { fg = "#4dbf57", bg = "#232222" })
  highlight("DiffChange", { fg = "#128cff", bg = "#232222" })
  highlight("DiffDelete", { fg = "#e21515", bg = "#232222" })
  highlight("DiffText", { fg = "#128cff", bg = "#403e3e" })

  -- Diagnostics
  highlight("DiagnosticError", { fg = "#e21515" })
  highlight("DiagnosticWarn", { fg = "#ffc501" })
  highlight("DiagnosticInfo", { fg = "#4dbf57" })
  highlight("DiagnosticHint", { fg = "#128cff" })
  highlight("DiagnosticUnderlineError", { sp = "#e21515", style = "underline" })
  highlight("DiagnosticUnderlineWarn", { sp = "#ffc501", style = "underline" })
  highlight("DiagnosticUnderlineInfo", { sp = "#4dbf57", style = "underline" })
  highlight("DiagnosticUnderlineHint", { sp = "#128cff", style = "underline" })

  -- Syntax highlighting
  highlight("Comment", { fg = "#7f8c98" })
  highlight("String", { fg = "#fe8170" })
  highlight("Character", { fg = "#fe8170" })
  highlight("Number", { fg = "#d8c87c" })
  highlight("Boolean", { fg = "#fe7ab2" })
  highlight("Float", { fg = "#d8c87c" })
  highlight("Constant", { fg = "#ffffffd9" })

  highlight("Identifier", { fg = "#ffffffd9" })
  highlight("Function", { fg = "#4db1cb" })
  highlight("Method", { fg = "#4db1cb" })
  
  -- Function calls (before LSP/Treesitter loads)
  highlight("Call", { fg = "#4db1cb" })

  highlight("Statement", { fg = "#fe7ab2" })
  highlight("Conditional", { fg = "#fe7ab2" })
  highlight("Repeat", { fg = "#fe7ab2" })
  highlight("Label", { fg = "#ffffffd9" })
  highlight("Operator", { fg = "#ffffffd9" })
  highlight("Keyword", { fg = "#fe7ab2" })
  highlight("Exception", { fg = "#fe7ab2" })
  
  -- Additional syntax groups
  highlight("jsArrowFunction", { fg = "#ffffffd9" })
  highlight("typescriptArrowFunc", { fg = "#ffffffd9" })

  highlight("PreProc", { fg = "#fe7ab2" })
  highlight("Include", { fg = "#fe7ab2" })
  highlight("Define", { fg = "#fe7ab2" })
  highlight("Macro", { fg = "#fe7ab2" })
  highlight("PreCondit", { fg = "#fe7ab2" })

  highlight("Type", { fg = "#d9baff" })
  highlight("StorageClass", { fg = "#fe7ab2" })
  highlight("Structure", { fg = "#6bdfff" })
  highlight("Typedef", { fg = "#fe7ab2" })
  
  -- Built-in support types (Date, Promise, etc.)
  highlight("typescriptBOMWindowProp", { fg = "#d9baff" })
  highlight("typescriptGlobal", { fg = "#d9baff" })
  highlight("typescriptPredefinedType", { fg = "#d9baff" })

  highlight("Special", { fg = "#ffffffd9" })
  highlight("SpecialChar", { fg = "#fe8170" })
  highlight("Tag", { fg = "#fe7ab2" })
  highlight("Delimiter", { fg = "#ffffffd9" })
  highlight("SpecialComment", { fg = "#7f8c98" })
  highlight("Debug", { fg = "#e21515" })
  
  -- Rainbow brackets (for rainbow-delimiters.nvim)
  -- Level 0: Yellow, Level 1: Violet, Level 2: Blue, then repeat
  highlight("RainbowDelimiterYellow", { fg = "#d9c97c" })
  highlight("RainbowDelimiterViolet", { fg = "#dabaff" })
  highlight("RainbowDelimiterBlue", { fg = "#6bdfff" })
  highlight("RainbowDelimiterOrange", { fg = "#ffa14f" })
  highlight("RainbowDelimiterGreen", { fg = "#acf2e4" })
  highlight("RainbowDelimiterRed", { fg = "#ff8170" })
  highlight("RainbowDelimiterCyan", { fg = "#4eb0cc" })
  
  -- Legacy rainbow-parentheses
  highlight("rainbowcol1", { fg = "#d9c97c" })
  highlight("rainbowcol2", { fg = "#dabaff" })
  highlight("rainbowcol3", { fg = "#6bdfff" })
  highlight("rainbowcol4", { fg = "#ffa14f" })
  highlight("rainbowcol5", { fg = "#acf2e4" })
  highlight("rainbowcol6", { fg = "#ff8170" })
  highlight("rainbowcol7", { fg = "#4eb0cc" })

  highlight("Underlined", { style = "underline" })
  highlight("Error", { fg = "#e21515" })
  highlight("Todo", { fg = "#128cff", bg = "#403e3e" })

  -- Treesitter highlights
  highlight("@comment", { fg = "#7f8c98" })
  highlight("@comment.documentation", { fg = "#7f8c98" })
  highlight("@string", { fg = "#fe8170" })
  highlight("@string.escape", { fg = "#fe8170" })
  highlight("@string.special", { fg = "#fe8170" })
  highlight("@character", { fg = "#fe8170" })
  highlight("@number", { fg = "#d8c87c" })
  highlight("@number.float", { fg = "#d8c87c" })
  highlight("@boolean", { fg = "#fe7ab2" })
  highlight("@constant", { fg = "#ffffffd9" })
  highlight("@constant.builtin", { fg = "#fe7ab2" })
  highlight("@constant.macro", { fg = "#fe7ab2" })
  highlight("@keyword", { fg = "#fe7ab2" })
  highlight("@keyword.function", { fg = "#fe7ab2" })
  highlight("@keyword.operator", { fg = "#fe7ab2" })
  highlight("@keyword.return", { fg = "#fe7ab2" })
  highlight("@keyword.import", { fg = "#fe7ab2" })
  highlight("@keyword.conditional", { fg = "#fe7ab2" })
  highlight("@keyword.repeat", { fg = "#fe7ab2" })
  highlight("@keyword.storage", { fg = "#fe7ab2" })
  highlight("@operator", { fg = "#ffffffd9" })
  highlight("@operator.arithmetic", { fg = "#b281eb" })
  highlight("@punctuation.bracket", { fg = "#ffffffd9" })
  highlight("@punctuation.delimiter", { fg = "#ffffffd9" })
  highlight("@punctuation.special", { fg = "#ffffffd9" })
  -- Functions and methods (before LSP loads)
  highlight("@function", { fg = "#4db1cb" })
  highlight("@function.call", { fg = "#4db1cb" })
  highlight("@function.method", { fg = "#4db1cb" })
  highlight("@function.method.call", { fg = "#4db1cb" })
  highlight("@function.builtin", { fg = "#4db1cb" })
  highlight("@function.macro", { fg = "#4db1cb" })
  highlight("@method", { fg = "#4db1cb" })
  highlight("@method.call", { fg = "#4db1cb" })
  
  -- TypeScript/JavaScript specific function calls (before LSP)
  highlight("@function.call.typescript", { fg = "#4db1cb" })
  highlight("@function.call.typescriptreact", { fg = "#4db1cb" })
  highlight("@function.call.javascript", { fg = "#4db1cb" })
  highlight("@function.call.javascriptreact", { fg = "#4db1cb" })
  
  highlight("@method.call.typescript", { fg = "#4db1cb" })
  highlight("@method.call.typescriptreact", { fg = "#4db1cb" })
  highlight("@method.call.javascript", { fg = "#4db1cb" })
  highlight("@method.call.javascriptreact", { fg = "#4db1cb" })
  
  -- Property method calls
  highlight("@variable.member.call", { fg = "#4db1cb" })
  highlight("@variable", { fg = "#ffffffd9" })
  highlight("@variable.builtin", { fg = "#fe7ab2" })
  
  -- Parameters (before LSP loads) - WHITE
  highlight("@variable.parameter", { fg = "#ffffffd9" })
  highlight("@variable.parameter.builtin", { fg = "#fe7ab2" })
  highlight("@parameter", { fg = "#ffffffd9" })
  
  -- TypeScript/JavaScript specific parameters
  highlight("@variable.parameter.typescript", { fg = "#ffffffd9" })
  highlight("@variable.parameter.typescriptreact", { fg = "#ffffffd9" })
  highlight("@variable.parameter.javascript", { fg = "#ffffffd9" })
  highlight("@variable.parameter.javascriptreact", { fg = "#ffffffd9" })
  
  highlight("@parameter.typescript", { fg = "#ffffffd9" })
  highlight("@parameter.typescriptreact", { fg = "#ffffffd9" })
  highlight("@parameter.javascript", { fg = "#ffffffd9" })
  highlight("@parameter.javascriptreact", { fg = "#ffffffd9" })
  
  -- Property and member access (before LSP loads)
  -- foo.mid -> light teal
  highlight("@variable.member", { fg = "#abf2e4" })
  highlight("@property", { fg = "#ffffffd9" })
  highlight("@field", { fg = "#ffffffd9" })
  
  -- TypeScript/JavaScript specific member access
  highlight("@variable.member.typescript", { fg = "#abf2e4" })
  highlight("@variable.member.typescriptreact", { fg = "#abf2e4" })
  highlight("@variable.member.javascript", { fg = "#abf2e4" })
  highlight("@variable.member.javascriptreact", { fg = "#abf2e4" })
  highlight("@type", { fg = "#d9baff" })
  highlight("@type.builtin", { fg = "#d9baff" })
  highlight("@type.definition", { fg = "#b181ec" })
  highlight("@type.qualifier", { fg = "#fe7ab2" })
  highlight("@constructor", { fg = "#6bdfff" })
  
  -- Note: Property colors by context
  -- - Object literal keys: #ffffffd9 (white) - @property
  -- - Object property access: #abf2e4 (light teal) - @variable.member
  -- - Type declaration keys: #6bdfff (sky blue) - @lsp.typemod.property.declaration
  -- - Object methods: #4db1cb (cyan) - @function.method.call
  highlight("@namespace", { fg = "#d9baff" })
  highlight("@module", { fg = "#d9baff" })
  highlight("@attribute", { fg = "#cc9767" })
  highlight("@label", { fg = "#fe7ab2" })
  highlight("@tag", { fg = "#fe7ab2" })
  highlight("@tag.attribute", { fg = "#cc9767" })
  highlight("@tag.delimiter", { fg = "#ffffffd9" })

  -- LSP semantic tokens
  highlight("@lsp.type.class", { fg = "#6bdfff" })
  highlight("@lsp.type.decorator", { fg = "#cc9767" })
  highlight("@lsp.type.enum", { fg = "#6bdfff" })
  highlight("@lsp.type.enumMember", { fg = "#abf2e4" })
  highlight("@lsp.type.function", { fg = "#4db1cb" })
  highlight("@lsp.type.interface", { fg = "#b181ec" })
  highlight("@lsp.type.macro", { fg = "#fe7ab2" })
  highlight("@lsp.type.method", { fg = "#4db1cb" })
  highlight("@lsp.type.namespace", { fg = "#d9baff" })
  highlight("@lsp.type.struct", { fg = "#6bdfff" })
  highlight("@lsp.type.type", { fg = "#d9baff" })
  highlight("@lsp.type.typeParameter", { fg = "#6bdfff" })
  highlight("@lsp.type.variable", { fg = "#ffffffd9" })
  highlight("@lsp.type.parameter", { fg = "#ffffffd9" })
  
  -- Member access (methods): foo.post() (cyan like other functions)
  highlight("@lsp.type.member", { fg = "#4db1cb" })
  
  -- Clear @lsp.mod.declaration to allow specific typemod overrides
  vim.api.nvim_set_hl(0, "@lsp.mod.declaration", {})
  
  highlight("@lsp.mod.readonly", { fg = "#ffffffd9" })
  highlight("@lsp.mod.constant", { fg = "#ffffffd9" })
  highlight("@lsp.mod.static", { fg = "#abf2e4" })
  highlight("@lsp.typemod.variable.readonly", { fg = "#ffffffd9" })
  highlight("@lsp.typemod.property.readonly", { fg = "#abf2e4" })
  highlight("@lsp.typemod.variable.constant", { fg = "#ffffffd9" })
  highlight("@lsp.typemod.variable.defaultLibrary", { fg = "#fe7ab2" })
  highlight("@lsp.typemod.function.defaultLibrary", { fg = "#b281eb" })
  highlight("@lsp.typemod.method.defaultLibrary", { fg = "#b281eb" })
  highlight("@lsp.typemod.class.defaultLibrary", { fg = "#d9baff" })
  highlight("@lsp.typemod.type.defaultLibrary", { fg = "#d9baff" })
  highlight("@lsp.typemod.interface.defaultLibrary", { fg = "#d9baff" })
  highlight("@lsp.typemod.variable.local", { fg = "#ffffffd9" })
  
  -- Type declaration context
  -- Parameter in function type: (args: { bar: string }) - 'args' white
  vim.api.nvim_set_hl(0, "@lsp.typemod.parameter.declaration", { fg = "#ffffff", ctermfg = 15 })
  
  -- Property in type declaration - DISABLED to allow Treesitter/syntax control
  -- We can't distinguish type annotation {bar:string} from object literal {P_STATUS:value} via LSP alone
  vim.api.nvim_set_hl(0, "@lsp.typemod.property.declaration", {})

  -- Markdown
  highlight("@markup.heading", { fg = "#6bdfff" })
  highlight("@markup.strong", { fg = "#6bdfff" })
  highlight("@markup.italic", { fg = "#d9baff" })
  highlight("@markup.quote", { fg = "#d9baff" })
  highlight("@markup.link", { fg = "#128cff" })
  highlight("@markup.link.url", { fg = "#fe8170" })

  -- NvimTree / Neo-tree
  highlight("NvimTreeNormal", { fg = "#dedede", bg = "#353333" })
  highlight("NvimTreeVertSplit", { fg = "#101010", bg = "#101010" })
  highlight("NvimTreeRootFolder", { fg = "#128cff" })
  highlight("NvimTreeFolderIcon", { fg = "#128cff" })
  highlight("NeoTreeNormal", { fg = "#dedede", bg = "#353333" })
  highlight("NeoTreeBorder", { fg = "#101010", bg = "#353333" })

  -- Telescope
  highlight("TelescopeNormal", { fg = "#dedede", bg = "#2c2c2b" })
  highlight("TelescopeBorder", { fg = "#515151", bg = "#2c2c2b" })
  highlight("TelescopeSelection", { fg = "#ebebeb", bg = "#464646" })
  highlight("TelescopeMatching", { fg = "#128cff" })

  -- GitSigns
  highlight("GitSignsAdd", { fg = "#4dbf57" })
  highlight("GitSignsChange", { fg = "#128cff" })
  highlight("GitSignsDelete", { fg = "#e21515" })

  -- Other
  highlight("Title", { fg = "#6bdfff" })
  highlight("Directory", { fg = "#128cff" })
  highlight("SpecialKey", { fg = "#777777" })
  highlight("NonText", { fg = "#747478" })
  highlight("MatchParen", { bg = "#6e6e6e" })
  highlight("Question", { fg = "#4dbf57" })
  highlight("MoreMsg", { fg = "#4dbf57" })
  highlight("WarningMsg", { fg = "#ffc501" })
  highlight("ErrorMsg", { fg = "#e21515" })
  highlight("Conceal", { fg = "#747478" })
  highlight("Whitespace", { fg = "#747478" })
  
  -- Additional language-specific highlights
  highlight("@lsp.type.variable.typescript", { fg = "#ffffffd9" })
  highlight("@lsp.type.variable.typescriptreact", { fg = "#ffffffd9" })
  highlight("@lsp.type.variable.javascript", { fg = "#ffffffd9" })
  highlight("@lsp.type.variable.javascriptreact", { fg = "#ffffffd9" })
  
  -- JSX/TSX
  highlight("@tag.tsx", { fg = "#fe7ab2" })
  highlight("@tag.jsx", { fg = "#fe7ab2" })
  highlight("@tag.builtin.tsx", { fg = "#fe7ab2" })
  highlight("@tag.builtin.jsx", { fg = "#fe7ab2" })
  highlight("@constructor.tsx", { fg = "#6bdfff" })
  highlight("@constructor.jsx", { fg = "#6bdfff" })
  
  -- Force clear LSP semantic tokens that should use Treesitter/Syntax
  local lsp_groups_to_clear = {
    "@lsp.type.keyword",
    "@lsp.type.modifier",
    "@lsp.type.property",
    "@lsp.mod.async",
    "@lsp.mod.definition",
    "@lsp.typemod.keyword.declaration",
    "@lsp.typemod.variable.declaration",
  }
  
  for _, group in ipairs(lsp_groups_to_clear) do
    vim.api.nvim_set_hl(0, group, {})
  end
  
  -- TypeScript/JavaScript specific overrides
  highlight("typescriptImport", { fg = "#fe7ab2" })
  highlight("typescriptExport", { fg = "#fe7ab2" })
  highlight("typescriptBOM", { fg = "#d9baff" })
  highlight("typescriptIdentifier", { fg = "#fe7ab2" })
  highlight("typescriptOperator", { fg = "#fe7ab2" })
  highlight("typescriptVariable", { fg = "#fe7ab2" })
  highlight("typescriptStorageClass", { fg = "#fe7ab2" })
  
  -- TypeScript syntax highlights (applied before LSP loads)
  -- IMPORTANT: These need to be set to override vim-typescript defaults
  
  -- Object literal keys: { P_STATUS: ... } - white
  highlight("typescriptObjectLabel", { fg = "#ffffffd9" })
  
  -- All property-like things unified to light teal for consistency
  -- Type annotation keys: { bar: string } - light teal
  highlight("typescriptMember", { fg = "#abf2e4" })
  highlight("typescriptObjectType", { fg = "#d9baff" })
  highlight("typescriptTypeReference", { fg = "#d9baff" })
  
  -- Property access: foo.mid - light teal (same as above)
  highlight("typescriptProp", { fg = "#abf2e4" })
  
  -- Function and method identifiers
  highlight("typescriptFuncName", { fg = "#4db1cb" })
  highlight("typescriptFuncKeyword", { fg = "#fe7ab2" })
  highlight("typescriptMethodName", { fg = "#4db1cb" })
  
  -- Parameters in function definitions - white (matches LSP)
  highlight("typescriptVariable", { fg = "#fe7ab2" })
  highlight("typescriptParamImpl", { fg = "#ffffffd9" })
  highlight("typescriptIdentifierName", { fg = "#ffffffd9" })
  highlight("typescriptFuncCallArg", { fg = "#ffffffd9" })
  highlight("typescriptArrowFuncArg", { fg = "#ffffffd9" })
  
  -- Arrow function definitions
  highlight("typescriptArrowFunc", { fg = "#ffffffd9" })
  
  -- Ensure Label (used by P_STATUS) is white, not pink
  highlight("Label", { fg = "#ffffffd9" })
  
  -- Built-in classes and objects should be purple
  highlight("@type.builtin.typescript", { fg = "#d9baff" })
  highlight("@type.builtin.typescriptreact", { fg = "#d9baff" })
  highlight("@type.builtin.javascript", { fg = "#d9baff" })
  highlight("@type.builtin.javascriptreact", { fg = "#d9baff" })
  
  -- Additional context-sensitive overrides
  -- Object method definitions should use function color
  highlight("@function.method.call", { fg = "#4db1cb" })
  highlight("@method.call", { fg = "#4db1cb" })
  
  -- Force override TypeScript syntax groups (at the end to ensure they stick)
  -- These override vim-typescript plugin defaults
  vim.cmd("highlight! typescriptCall guifg=#4db1cb gui=NONE")
  vim.cmd("highlight! typescriptFuncCall guifg=#4db1cb gui=NONE")
  vim.cmd("highlight! typescriptFuncName guifg=#4db1cb gui=NONE")
  vim.cmd("highlight! typescriptMethodName guifg=#4db1cb gui=NONE")
  
  -- Parameter colors - force white
  vim.cmd("highlight! typescriptParamImpl guifg=#ffffffd9 gui=NONE")
  vim.cmd("highlight! typescriptFuncCallArg guifg=#ffffffd9 gui=NONE")
  vim.cmd("highlight! typescriptArrowFuncArg guifg=#ffffffd9 gui=NONE")
  
  -- Arrow function arrow
  vim.cmd("highlight! link typescriptArrowFunc Operator")
  
  -- Create autocmd to reapply highlights after FileType detection
  -- Use defer to ensure it applies AFTER other plugins
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    callback = function()
      vim.defer_fn(function()
        -- Reapply TypeScript/JavaScript specific highlights
        vim.cmd("highlight! typescriptCall guifg=#4db1cb gui=NONE")
        vim.cmd("highlight! typescriptFuncCall guifg=#4db1cb gui=NONE")
        vim.cmd("highlight! typescriptFuncName guifg=#4db1cb gui=NONE")
        vim.cmd("highlight! typescriptMethodName guifg=#4db1cb gui=NONE")
        vim.cmd("highlight! typescriptParamImpl guifg=#ffffffd9 gui=NONE")
        vim.cmd("highlight! typescriptFuncCallArg guifg=#ffffffd9 gui=NONE")
        vim.cmd("highlight! typescriptArrowFuncArg guifg=#ffffffd9 gui=NONE")
        vim.cmd("highlight! typescriptObjectLabel guifg=#ffffffd9 gui=NONE")
        vim.cmd("highlight! typescriptProp guifg=#abf2e4 gui=NONE")
        vim.cmd("highlight! typescriptMember guifg=#abf2e4 gui=NONE")
      end, 10)  -- 10ms delay to ensure other plugins loaded
    end
  })
  
  -- Create autocmd to reapply after ColorScheme change
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      if vim.g.colors_name == "macos_dark" then
        return  -- Don't reapply if we just set our own colorscheme
      end
      M.setup()  -- Reapply our colors
    end
  })
  
  -- Set colorscheme name at the end
  vim.g.colors_name = "macos_dark"
end

-- NOTE: Rainbow brackets require a plugin like:
--   - rainbow-delimiters.nvim (recommended for latest Neovim)
--   - nvim-ts-rainbow (legacy)
-- Add to your plugin manager to enable colored parentheses/brackets

return M
