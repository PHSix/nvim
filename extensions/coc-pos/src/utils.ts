import { DocumentSymbol, Position, Range } from "coc.nvim";

export function getSymbolPath(
	pos: Position,
	docuemntSymbols: DocumentSymbol[],
	maxTravelDepth: number
): [DocumentSymbol[], number] {
	const result: DocumentSymbol[] = [];
	let travelDepth = 0;
	let symbols: DocumentSymbol[] | undefined = docuemntSymbols;

	while (symbols !== void 0 && travelDepth < maxTravelDepth) {
		travelDepth++;
		const len = result.length;
		for (const symbol of symbols) {
			if (posInRange(pos, symbol.range)) {
				symbols = symbol.children;
				result.push(symbol);
				break;
			}
		}

		if (len === result.length) {
			return [result, travelDepth];
		}
	}

	return [result, travelDepth];
}

export function getFilename(uri: string): string {
	return uri.split("/").pop() || "";
}

export function posInRange(pos: Position, range: Range) {
	return (
		(pos.line < range.end.line ||
			(pos.line === range.end.line && pos.character <= range.end.character)) &&
		(pos.line > range.start.line ||
			(pos.line === range.start.line && pos.character >= range.start.character))
	);
}
