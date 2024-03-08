import type {
  Disposable,
  DocumentSelector,
  ExtensionContext,
} from 'coc.nvim'
import {
  Range,
  TextEdit,
  Uri,
  executable,
  languages,
  window,
  workspace,
} from 'coc.nvim'
import { doFormat } from './format'

export async function activate(context: ExtensionContext): Promise<void> {
  const config = workspace.getConfiguration('coc-stylua')
  if (!config.get('enable') || !executable('stylua'))
    return

  const selector: DocumentSelector = ['lua']
  let provider: Disposable | undefined

  function registerProvider() {
    provider = languages.registerDocumentFormatProvider(
      selector,
      {
        provideDocumentFormattingEdits(textDocument, _, token) {
          const document = workspace.getDocument(textDocument.uri)
          const text = textDocument.getText()
          const activeTextEditor = window.activeTextEditor

          if (activeTextEditor === void 0)
            return

          const folder = workspace.getWorkspaceFolder(
            activeTextEditor.document.uri,
          )
          const cwd = folder ? Uri.parse(folder.uri).fsPath : void 0

          return doFormat(text, { cwd, logger: context.logger })
            .then((result) => {
              if (result === void 0)
                return void 0
              if (token.isCancellationRequested)
                return void 0

              const endLine = document.lineCount - 1
              const range = Range.create(
                { character: 0, line: 0 },
                {
                  character: document.getline(endLine).length,
                  line: endLine,
                },
              )

              return [TextEdit.replace(range, result)]
            })
            .catch((err) => {
              window.showErrorMessage(Object.toString.call(err))
              return void 0
            })
        },
      },
      999,
    )
  }

  workspace.onDidChangeConfiguration(() => {
    const value = workspace
      .getConfiguration()
      .get<boolean>('coc-stylua.enable')

    if (value && !provider) {
      registerProvider()
      context.subscriptions = [provider!]
    } else {
      provider?.dispose()
      provider = undefined
      context.subscriptions = []
    }
  })

  registerProvider()

  context.subscriptions = [provider!]
}
