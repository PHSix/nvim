vim.g.colors_name = "coolors"

-- {{{ variable define
local coolors = require("coolors")
local h = function(t)
	for key in pairs(t) do
		coolors.hi(t[key])
	end
end

local l = function(t)
	for key in pairs(t) do
		coolors.link(t[key])
	end
end

local w = coolors.get_colors()
local red = w.red
local orange = w.orange
local amber = w.amber
local yellow = w.yellow
local lime = w.lime
local green = w.green
local emerald = w.emerald
local teal = w.teal
local cyan = w.cyan
local light_blue = w.light_blue
local blue = w.blue
local indigo = w.indigo
local violet = w.violet
local purple = w.purple
local fuchsia = w.fuchsia
local pink = w.pink
local rose = w.rose
local warn_gray = w.warn_gray
local true_gray = w.true_gray
local gray = w.gray
local cool_gray = w.cool_gray
local blue_gray = w.blue_gray
local white = w.white
local black = w.black
local underline = "underline"
local italic = "italic"
local bold = "bold"
local none = w.transparent

local bg = gray["900"]
-- }}}

h({
	{ "Normal", bg = bg, fg = white },
	{ "Comment", fg = warn_gray["400"], italic },
	{ "LineNr", bg = bg, fg = blue_gray["600"] },
	{ "CursorLineNr", fg = rose["300"] },
	{ "SignColumn", bg = bg },
	{ "CursorLine", bg = gray["800"] },
	{ "Visual", bg = true_gray["600"] },
	{ "VertSplit", fg = bg, bg = cool_gray["600"] },
	{ "EndOfBuffer", fg = cool_gray["700"] },
	{ "NormalFloat", bg = true_gray["800"] },
	{ "Pmenu", bg = blue_gray["700"] },
	{ "PmenuSel", bg = blue_gray["500"] },
	{ "WildMenu", bg = blue_gray["700"] },
	{ "Folded", bg = blue_gray["800"], fg = white },
	{ "FoldColumn", bg = blue_gray["800"], fg = white },
	{ "Whitespace", fg = gray["700"] },
	{ "NonText", fg = gray["700"] },
	{ "ModeMsg", fg = blue_gray["400"] },
	{ "NormalNC", fg = gray["300"] },
	{ "Search", bg = red["300"] },

	{ "Identifier", fg = lime["200"] },
	{ "Keyword", fg = pink["300"], bold },
	{ "Type", fg = emerald["200"] },
	{ "Function", fg = cyan["200"] },
	{ "Statement", fg = light_blue["400"] },
	{ "PreProc", fg = rose["400"] },
	{ "String", fg = rose["400"] },
	{ "Boolean", fg = orange["300"] },
	{ "Character", fg = rose["400"] },
	{ "Number", fg=green["300"] },
	{ "Float" , fg=green["300"]},

	-- diff
	{ "DiffAdd", bg = bg, fg = green["300"] },
	{ "DiffDelete", bg = bg, fg = pink["300"] },
	{ "DiffChange", bg = bg, fg = amber["300"] },

	-- disgnostic
	{ "Error", bg = red["600"] },
	{ "Warning", bg = yellow["600"] },
	{ "Hint", bg = true_gray["600"] },
	{ "Info", bg = gray["600"] },

	-- indent
	{ "IndentBlanklineChar", fg = gray["700"] },
	{ "IndentBlanklineContextChar", fg = lime["300"] },

	-- lspsaga
	{ "TargetWord", bg = none, fg = purple["200"] },
	{ "DefinitionCount", fg = gray["400"] },
	{ "ReferencesCount", fg = gray["400"] },

	{ "LspSagaLightBulbSign", fg = amber["400"] },
	{ "LspSagaLightBulb", fg = amber["400"] },

	{ "LspSagaHovBorder", fg = blue_gray["600"] },
	{ "LspSagaHoverBorder", fg = blue_gray["600"] },
	{ "LspSagaLspFinderBorder", fg = blue_gray["600"] },
	{ "LspSagaRenameBorder", fg = blue_gray["600"] },
	{ "LspSagaDiagnosticBorder", fg = blue_gray["600"] },
	{ "LspSagaCodeActionBorder", fg = blue_gray["600"] },
	{ "LspSagaDefPreviewBorder", fg = blue_gray["600"] },
	{ "LspSagaSignatureHelpBorder", fg = blue_gray["600"] },

	{ "LspSagaDiagnosticHeader", fg = red["400"] },

	{ "LspSagaDiagnosticTruncateLine", fg = blue_gray["600"] },

	{ "LspSagaCodeActionTruncateLine", fg = blue_gray["600"] },
	{ "LspSagaShTruncateLine", fg = blue_gray["600"] },
	{ "LspSagaDocTruncateLine", fg = blue_gray["600"] },

	-- lsp
	{ "DiagnosticError", fg = red["500"] },
	{ "DiagnosticWarn", fg = yellow["500"] },
	{ "DiagnosticHint", fg = gray["600"] },
	{ "DiagnosticInfo", fg = blue_gray["600"] },

	-- dashboard
	{ "DashboardHeader", fg = yellow["200"] },
	{ "DashboardMenu", fg = fuchsia["200"] },


	-- markdown
	{"TSTitle", fg=lime["400"], bold},

	-- cursor word
	{"CursorWord0", bg=blue_gray["700"], none},
	{"CursorWord1", bg=blue_gray["700"], none},

	-- symbol outline
	{"FocusedSymbol", bg=violet['500']},
})

l({
	{ "Conceal", "Normal" },
	{ "CursorColumn", "CursorLine" },
	{ "DiffText", "NormalFloat" },
})
