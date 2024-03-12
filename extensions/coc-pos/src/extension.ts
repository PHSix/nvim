import {
  CancellationTokenSource,
  ProviderName,
  events,
  languages,
  nvim,
  window,
  workspace,
} from 'coc.nvim'

import type {
  CancellationToken,
  Disposable,
  DocumentSymbol,
  ExtensionContext,
  TextDocument,
} from 'coc.nvim'

import debounce from 'debounce'
import { getComponentName, getFilename, getSymbolPath } from './utils'
import { renderWinbarString } from './render'

interface GetSymbolable {
  getDocumentSymbol: (
    document: TextDocument,
    token: CancellationToken,
  ) => Promise<DocumentSymbol[] | null>
}

let cancelTokenSource: CancellationTokenSource
let eventDisposable: Disposable | undefined
let maxTravelDepth: number
const symbolsCache = new Map<
    number,
    {
      changedtick: number
      symbols: DocumentSymbol[]
    }
  >()

function getMaxTravelDepth() {
  const depth = workspace
    .getConfiguration()
    .get<number>('coc-pos.maxTravelDepth')
  if (typeof depth !== 'number' || Number.isNaN(depth))
    return 30

  return depth
}

function createEventListen(context: ExtensionContext) {
  maxTravelDepth = getMaxTravelDepth()
  const log = context.logger

  eventDisposable = events.on(
    'CursorMoved',
    debounce(async (bufnr: number, cursor: [number, number]) => {
      const document = workspace.getDocument(bufnr)
      const win = window.activeTextEditor?.winid !== void 0 ? nvim.createWindow(window.activeTextEditor.winid) : undefined

      if (
        !document
        || !document.attached
        || !document.textDocument
        || document.winid === -1
        || !win
        || !(await win.valid)
        || await document.buffer.getOption('bufhidden') !== ''
        || !languages.hasProvider(
          ProviderName.DocumentSymbol,
          document.textDocument,
        )
      )
        return

      const windowConfig = await win.getConfig()

      if (windowConfig.relative)
        return
      context.logger.info(windowConfig)

      const folderUri = workspace.getWorkspaceFolder(
        document.textDocument.uri,
      )?.uri

      if (!folderUri)
        return

      // last change doucment tick
      const changedtick = await nvim.call('nvim_buf_get_var', [
        bufnr,
        'changedtick',
      ])

      let symbols: DocumentSymbol[]

      const cache = symbolsCache.get(bufnr)

      if (cache && cache.changedtick === changedtick) {
        // get symbols from cache
        symbols = cache.symbols
      } else {
        // request and cached symbols
        cancelTokenSource?.cancel()
        cancelTokenSource?.dispose()
        cancelTokenSource = new CancellationTokenSource()

        const res = await (
          languages as any as GetSymbolable
        ).getDocumentSymbol(document.textDocument, cancelTokenSource.token)

        if (!res)
          return

        symbols = res

        symbolsCache.set(bufnr, {
          changedtick,
          symbols,
        })
      }

      try {
        const [symbolPath] = getSymbolPath(
          {
            line: cursor[0] - 1,
            character: cursor[1] - 1,
          },
          symbols,
          maxTravelDepth,
        )
        const filename = getFilename(folderUri)
        const componentName = getComponentName(
          document.uri.slice(folderUri.length),
        )

        const winbar = renderWinbarString(
          componentName
            ? ` ${filename}:${componentName}`
            : ` ${filename}`,
          symbolPath,
        )

        // check current buffer is not changed
        if ((await nvim.window).id === win.id) {
          win.setOption('winbar', winbar).catch(
            (err) => {
              log.error(err, winbar)
            },
          )
        }
      } catch (err: any) {
        log.debug(`coc-pos catch some error : ${err.toString()}`)
      }
    }, 70),
    // delete cache.
    workspace.registerAutocmd({
      event: ['BufDelete', 'BufWipeout'],
      pattern: '*',
      callback: (args: any) => {
        try {
          if (args && args.buf && symbolsCache.has(args.buf))
            symbolsCache.delete(args.buf)
        } catch (err) {
          log.error(Object.toString.call(err))
        }
      },
    }),
  )

  context.subscriptions.push(eventDisposable)
}

export async function activate(context: ExtensionContext): Promise<void> {
  const config = workspace.getConfiguration('coc-pos')
  const enable = config.get<boolean>('enable', true)

  if (enable === true)
    createEventListen(context)

  context.subscriptions.push(workspace.onDidChangeConfiguration((e) => {
    if (e.affectsConfiguration('coc-pos.enable')) {
      if (config.get('enable', true)) {
        createEventListen(context)
      } else {
        eventDisposable?.dispose()
        context.subscriptions = context.subscriptions.filter(s => s !== eventDisposable)
        for (const buf of symbolsCache.keys()) {
          symbolsCache.delete(buf)
          nvim.request('nvim_set_option_value', ['winbar', '', { buf }])
        }
      }
    }

    if (e.affectsConfiguration('coc-pos.maxTravelDepth'))
      maxTravelDepth = getMaxTravelDepth()
  }))
}

export function deactivate() {
  eventDisposable?.dispose()

  for (const key of symbolsCache.keys())
    symbolsCache.delete(key)
}
