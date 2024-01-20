import { DocumentSymbol } from "coc.nvim";

export function getSymbolPath(
  row: number,
  col: number,
  symbols: DocumentSymbol[],
  result: DocumentSymbol[] = [],
  depth = 0
): DocumentSymbol[] {
  if (depth === 100) {
    throw Error("getPath too depth");
  }

  for (const symbol of symbols) {
    switch (true) {
      case symbol.range.start.line < row && symbol.range.end.line > row: {
        result.push(symbol);

        return !!symbol.children
          ? getSymbolPath(row, col, symbol.children, result, depth + 1)
          : result;
      }

      case symbol.range.start.line === symbol.range.end.line: {
        if (
          col >= symbol.range.start.character &&
          col <= symbol.range.end.character
        ) {
          return !!symbol.children
            ? getSymbolPath(row, col, symbol.children, result, depth + 1)
            : result;
        }
        break;
      }
      case symbol.range.start.line === row: {
        if (col >= symbol.range.start.character) {
          return !!symbol.children
            ? getSymbolPath(row, col, symbol.children, result, depth + 1)
            : result;
        }
        break;
      }

      case symbol.range.end.line === row: {
        if (col <= symbol.range.end.character) {
          return !!symbol.children
            ? getSymbolPath(row, col, symbol.children, result, depth + 1)
            : result;
        }
        break;
      }
    }
  }

  return result;
}

export function getFilename(uri: string): string {
  return uri.split("/").pop() || "";
}
