import {
  DocumentSelector,
  ExtensionContext,
  languages,
  Range,
  TextEdit,
  Uri,
  window,
  workspace,
} from "coc.nvim";
import { doFormat } from "./format";

export async function activate(context: ExtensionContext): Promise<void> {
  const config = workspace.getConfiguration("coc-stylua");
  if (config.get("enabled") === false) {
    return;
  }

  const selector: DocumentSelector = ["lua"];
  let enable = true;

  workspace.onDidChangeConfiguration(() => {
    const value = workspace
      .getConfiguration()
      .get<boolean>("coc-stylua.enable");

    if (value) {
      enable = value;
    }
  });

  context.subscriptions.push(
    languages.registerDocumentFormatProvider(
      selector,
      {
        provideDocumentFormattingEdits(textDocument, _, token) {
          if (enable === false) return;

          const document = workspace.getDocument(textDocument.uri);
          const text = textDocument.getText();
          const activeTextEditor = window.activeTextEditor;

          if (activeTextEditor === void 0) return;

          const folder = workspace.getWorkspaceFolder(
            activeTextEditor.document.uri
          );
          const cwd = folder ? Uri.parse(folder.uri).fsPath : void 0;

          const binPath = workspace
            .getConfiguration()
            .get<string>("coc-stylua.binPath");

          return doFormat(text, { cwd, binPath, logger: context.logger })
            .then((result) => {
              if (result === void 0) return void 0;
              if (token.isCancellationRequested) return void 0;

              const endLine = document.lineCount - 1;
              const range = Range.create(
                { character: 0, line: 0 },
                {
                  character: document.getline(endLine).length,
                  line: endLine,
                }
              );

              return [TextEdit.replace(range, result)];
            })
            .catch((err) => {
              window.showErrorMessage(Object.toString.call(err));
              return void 0;
            });
        },
      },
      999
    )
  );
}
