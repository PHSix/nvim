import type { DocumentSymbol, Position, Range } from 'coc.nvim'

const invaildFileName = new Set([
  'index.ts',
  'index.tsx',
  'index.js',
  'index.jsx',
  'index.vue',
  'index.cjs',
  'index.mjs',
  'index.css',
  'index.less',
  'index.sass',
  'index.scss',
  'index.module.css',
  'index.module.less',
  'index.module.sass',
  'index.module.scss',
  'init.lua',
  'index.d.ts',
  'init.go',
])

export function getSymbolPath(
  pos: Position,
  docuemntSymbols: DocumentSymbol[],
  maxTravelDepth: number,
): [DocumentSymbol[], number] {
  const result: DocumentSymbol[] = []
  let travelDepth = 0
  let symbols: DocumentSymbol[] | undefined = docuemntSymbols

  while (symbols !== void 0 && symbols.length !== 0 && travelDepth < maxTravelDepth) {
    travelDepth++
    const len = result.length
    for (const symbol of symbols) {
      if (rangeContain(symbol.range, pos)) {
        symbols = symbol.children
        result.push(symbol)
        break
      }
    }

    if (len === result.length)
      return [result, travelDepth]
  }

  return [result, travelDepth]
}

export function getFilename(uri: string): string {
  return uri.split('/').pop() || ''
}

export function getComponentName(uri: string) {
  const filePath = uri.split('/').filter(s => s !== '')

  if (filePath.length === 0)
    return undefined

  if (invaildFileName.has(filePath[filePath.length - 1]) && filePath.length > 1)
    return `${filePath[filePath.length - 2]}/${filePath[filePath.length - 1]}`

  return filePath[filePath.length - 1]
}

export function rangeContain(range: Range, position: Position) {
  return (
    (position.line < range.end.line
    || (position.line === range.end.line
    && position.character <= range.end.character))
    && (position.line > range.start.line
    || (position.line === range.start.line
    && position.character >= range.start.character))
  )
}
