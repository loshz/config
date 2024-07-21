vim.cmd("hi clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

local hl = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

vim.g.colors_name = "dark"

-- colors
local colors = {
	dark              = "#121212",
	dark_alt          = "#303030",
	light             = "#FFFFFF",
	red               = "#F66151",
	green             = "#8FF0A4",
	blue              = "#62A0EA",
	yellow            = "#F9F06B",
	orange            = "#FFBE6F",
	purple            = "#DC8ADD",
	teal              = "#93DDC2",
	violet            = "#7D8AC7",
	popup             = "#282828",
	comment           = "#AAAAAA"
}

-- terminal colors
vim.g.terminal_color_0          = colors.dark
vim.g.terminal_color_1          = colors.red
vim.g.terminal_color_2          = colors.green
vim.g.terminal_color_3          = colors.orange
vim.g.terminal_color_4          = colors.blue
vim.g.terminal_color_5          = colors.purple
vim.g.terminal_color_6          = colors.teal
vim.g.terminal_color_7          = colors.light
vim.g.terminal_color_8          = colors.light
vim.g.terminal_color_9          = colors.red
vim.g.terminal_color_10         = colors.green
vim.g.terminal_color_11         = colors.orange
vim.g.terminal_color_12         = colors.blue
vim.g.terminal_color_13         = colors.purple
vim.g.terminal_color_14         = colors.teal
vim.g.terminal_color_15         = colors.light
vim.g.terminal_color_background = colors.dark
vim.g.terminal_color_foreground = colors.light

-- UI highlight
hl('Normal', { fg = colors.light, bg = colors.dark })
hl('NormalFloat', { fg = colors.light, bg = colors.popup })
hl('FloatBorder', { fg = colors.dark_alt, bg = colors.popup })
hl('ColorColumn', { bg = colors.dark_alt })
hl('Cursor', { fg = colors.dark, bg = colors.light })
hl('CursorLine', { bg = colors.dark_alt })
hl('CursorColumn', { bg = colors.dark_alt })
hl('Directory', { fg = colors.light, bg = colors.dark })
hl('DiffAdd', { fg = colors.teal, bg = colors.dark })
hl('DiffChange', { fg = colors.orange, bg = colors.dark })
hl('DiffDelete', { fg = colors.red, bg = colors.dark })
hl('DiffText', { fg = colors.violet, bg = colors.dark })
hl('EndOfBuffer', { fg = colors.dark, bg = colors.dark })
hl('ErrorMsg', { fg = colors.red, bg = colors.dark, underline = true })
hl('VertSplit', { fg = colors.dark_alt, bg = colors.dark })
hl('WinSeparator', { link = 'VertSplit' })
hl('Folded', { fg = colors.dark, bg = colors.dark })
hl('FoldColumn', { fg = colors.dark, bg = colors.dark })
hl('SignColumn', { fg = colors.dark, bg = colors.dark })
hl('IncSearch', { fg = colors.dark, bg = colors.yellow })
hl('LineNr', { fg = colors.comment, bg = colors.dark })
hl('CursorLineNr', { fg = colors.light, bg = colors.dark_alt })
hl('MatchParen', { fg = colors.light, bold = true })
hl('ModeMsg', { fg = colors.light, bg = colors.dark_alt })
hl('MoreMsg', { fg = colors.light, bg = colors.dark_alt })
hl('NonText', { fg = colors.dark })
hl('Pmenu', { fg = colors.light, bg = colors.popup })
hl('PmenuSel', { fg = colors.light, bg = colors.red })
hl('PmenuSbar', { bg = colors.dark })
hl('PmenuThumb', { bg = colors.dark })
hl('Question', { fg = colors.blue, bg = colors.dark })
hl('Search', { fg = colors.dark, bg = colors.yellow })
hl('SpecialKey', { fg = colors.dark, bg = colors.dark })
hl('StatusLine', { fg = colors.light, bg = colors.dark_alt })
hl('StatusLineNC', { fg = colors.light, bg = colors.dark })
hl('Tabline', { fg = colors.light, bg = colors.dark_alt })
hl('TablineFill', { fg = colors.light, bg = colors.dark_alt })
hl('TablineSel', { fg = colors.light, bg = colors.dark })
hl('Title', { bold = true })
hl('Visual', { bg = colors.blue })
hl('VisualNOS', { bg = colors.blue })
hl('WarningMsg', { fg = colors.yellow, bold = true })
hl('WildMenu', { fg = colors.light, bg = colors.blue })

-- Syntax highlight
hl('Comment', { fg = colors.comment })
hl('Constant', { fg = colors.light })
hl('String', { fg = colors.teal })
hl('Character', { fg = colors.light })
hl('Number', { fg = colors.yellow })
hl('Boolean', { fg = colors.light, bold = true })
hl('Float', { fg = colors.teal })
hl('Identifier', { fg = colors.light })
hl('Function', { fg = colors.light })
hl('Statement', { fg = colors.orange, bold = true })
hl('Conditional', { fg = colors.orange, bold = true })
hl('Repeat', { fg = colors.orange, bold = true })
hl('Label', { fg = colors.purple })
hl('Operator', { fg = colors.purple })
hl('Keyword', { fg = colors.orange, bold = true })
hl('Exception', { fg = colors.orange, bold = true })
hl('PreProc', { fg = colors.orange })
hl('Include', { fg = colors.orange })
hl('Define', { fg = colors.orange, bold = true })
hl('Macro', { fg = colors.blue, bold = true })
hl('PreCondit', { fg = colors.orange, bold = true })
hl('Type', { fg = colors.teal })
hl('StorageClass', { fg = colors.orange, bold = true })
hl('Structure', { fg = colors.teal, bold = true })
hl('TypeDef', { fg = colors.teal, bold = true })
hl('Special', { fg = colors.blue })
hl('SpecialChar', { fg = colors.blue })
hl('Tag', { fg = colors.teal })
hl('Delimiter', { fg = colors.teal })
hl('SpecialComment', { fg = colors.comment, bold = true })
hl('Debug', { fg = colors.light, bold = true })
hl('Underlined', { underline = true })
hl('Ignore', { fg = colors.light })
hl('Error', { fg = colors.red, underline = true })
hl('SpellBad', { fg = colors.red, underline = true, sp = colors.red })
hl('SpellCap', { fg = colors.red, underline = true, sp = colors.red })
hl('SpellRare', { fg = colors.red, underline = true, sp = colors.red })
hl('SpellLocale', { fg = colors.red, underline = true, sp = colors.red })
hl('Todo', { fg = colors.light, bold = true })
hl('Whitespace', { fg = colors.dark })

-- LSP semantic tokens
hl('@lsp.type.class', { link = '@type' })
hl('@lsp.type.decorator', { link = '@function' })
hl('@lsp.type.enum', { link = '@structure' })
hl('@lsp.type.enumMember', { link = '@property' })
hl('@lsp.type.function', { link = '@function' })
hl('@lsp.type.interface', { link = '@type' })
hl('@lsp.type.macro', { link = '@macro' })
hl('@lsp.type.method', { link = '@function' })
hl('@lsp.type.namespace', { link = '@namespace' })
hl('@lsp.type.parameter', { link = '@parameter' })
hl('@lsp.type.property', { link = '@property' })
hl('@lsp.type.struct', { link = '@structure' })
hl('@lsp.type.type', { link = '@type' })
hl('@lsp.type.typeParameter', { link = '@type' })
hl('@lsp.type.variable', { link = '@variable' })
hl('@lsp.type.keyword', { link = '@keyword' })

hl('htmlTag', { fg = colors.teal })
hl('htmlEndTag', { fg = colors.teal })
hl('htmlTagName', { fg = colors.teal })
hl('htmlSpecialTagName', { fg = colors.teal })
hl('htmlArg', { fg = colors.orange })

hl('BufferLineIndicatorSelected', { bg = colors.dark })
hl('BufferLineFill', { bg = colors.dark_alt })

hl('CmpItemKind', { fg = colors.light })
