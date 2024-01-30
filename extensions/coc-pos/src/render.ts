import { DocumentSymbol, SymbolKind } from "coc.nvim";

type IconMap = Record<SymbolKind, { icon: string; key: string }>;

const iconMap: IconMap = {
	[SymbolKind.File]: { icon: "󰈙 ", key: "File" },
	[SymbolKind.Module]: { icon: " ", key: "Module" },
	[SymbolKind.Namespace]: { icon: "󰌗 ", key: "Namespace" },
	[SymbolKind.Package]: { icon: " ", key: "Package" },
	[SymbolKind.Class]: { icon: "󰌗 ", key: "Class" },
	[SymbolKind.Method]: { icon: "󰆧 ", key: "Method" },
	[SymbolKind.Property]: { icon: " ", key: "Property" },
	[SymbolKind.Field]: { icon: " ", key: "Field" },
	[SymbolKind.Constructor]: { icon: " ", key: "Constructor" },
	[SymbolKind.Enum]: { icon: "󰕘 ", key: "Enum" },
	[SymbolKind.Interface]: { icon: "󰕘 ", key: "Interface" },
	[SymbolKind.Function]: { icon: "󰊕 ", key: "Function" },
	[SymbolKind.Variable]: { icon: "󰆧 ", key: "Variable" },
	[SymbolKind.Constant]: { icon: "󰏿 ", key: "Constant" },
	[SymbolKind.String]: { icon: "󰀬 ", key: "String" },
	[SymbolKind.Number]: { icon: "󰎠 ", key: "Number" },
	[SymbolKind.Boolean]: { icon: "◩ ", key: "Boolean" },
	[SymbolKind.Array]: { icon: "󰅪 ", key: "Array" },
	[SymbolKind.Object]: { icon: "󰅩 ", key: "Object" },
	[SymbolKind.Key]: { icon: "󰌋 ", key: "Key" },
	[SymbolKind.Null]: { icon: "󰟢 ", key: "Null" },
	[SymbolKind.EnumMember]: { icon: " ", key: "EnumMember" },
	[SymbolKind.Struct]: { icon: "󰌗 ", key: "Struct" },
	[SymbolKind.Event]: { icon: " ", key: "Event" },
	[SymbolKind.Operator]: { icon: "󰆕 ", key: "Operator" },
	[SymbolKind.TypeParameter]: { icon: "󰊄 ", key: "TypeParameter" },
};

export function renderWinbarString(
	prefix: string,
	symbolPath: DocumentSymbol[]
) {
	let symbolLink = "";
	for (const symbol of symbolPath) {
		const { icon, key } = iconMap[symbol.kind];
		symbolLink += ` %#VertSplit# %#CocSymbol${key}#${icon}${symbol.name}`;
	}

	return " %#CocSymbolFile#" + prefix + symbolLink;
}
