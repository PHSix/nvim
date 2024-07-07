import type {
  CancellationToken,
  DocumentSymbol,
  ExtensionContext,
  TextDocument,
} from 'coc.nvim'
import {
  CancellationTokenSource,
  Disposable,
  ProviderName,
  disposeAll,
  events,
  languages,
  nvim,
  window,
  workspace,
} from 'coc.nvim'

import debounce from 'debounce'
import { getFilename, getSymbolPath } from './utils'
import { renderWinbar, renderWinbarString } from './render'

interface GetSymbolable {
  getDocumentSymbol: (
    document: TextDocument,
    token: CancellationToken,
  ) => Promise<DocumentSymbol[] | null>
}

let cancelTokenSource: CancellationTokenSource
let canDisposable: Disposable | undefined
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
  nvim.setOption('showtabline', 2)
  nvim.setOption('tabline', '')

  maxTravelDepth = getMaxTravelDepth()
  const log = context.logger

  const symbolEvent = events.on(
    'CursorMoved',
    debounce(async (bufnr: number, cursor: [number, number]) => {
      const document = workspace.getDocument(bufnr)

      if (
        !document
        || !document.attached
        || !document.textDocument
        || document.winid === -1
        || await document.buffer.getOption('bufhidden') !== ''
        || !languages.hasProvider(
          ProviderName.DocumentSymbol,
          document.textDocument,
        )
      )
        return

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
        const projectName = getFilename(folderUri)

        const tabline = renderWinbarString(` ${projectName}`, symbolPath)

        nvim.setOption('tabline', tabline)
      } catch (err: any) {
        log.debug(`coc-pos catch some error : ${err.toString()}`)
      }
    }, 70),
  )

  const winbarHandler = debounce(async () => {
    const editor = window.activeTextEditor
    if (!editor)
      return
    const uri = editor.document.uri
    const winid = editor.winid
    const folder = workspace.getWorkspaceFolder(uri)
    if (!folder)
      return

    const winbar = renderWinbar(uri.slice(folder.uri.length).split('/').filter(item => !!item))
    const win = nvim.createWindow(winid)
    if (await win.valid)
      await win.setOption('winbar', winbar).catch(() => {})
  }, 70)

  const timer = setTimeout(() => {
    winbarHandler()
  }, 1000)

  const eventListeners = [
    symbolEvent,
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
    // events.on('WinEnter', winbarHandler),
    // events.on('WinLeave', winbarHandler),
    // events.on('BufEnter', winbarHandler),
    // events.on('Enter', winbarHandler),
    Disposable.create(() => {
      clearTimeout(timer)
    }),
    workspace.registerAutocmd({
      event: ['BufReadPost', 'BufEnter'],
      callback: winbarHandler,
    }),
  ]

  canDisposable = Disposable.create(() => {
    disposeAll(eventListeners)
  })

  context.subscriptions.push(canDisposable)
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
        canDisposable?.dispose()
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
  for (const key of symbolsCache.keys())
    symbolsCache.delete(key)
}
