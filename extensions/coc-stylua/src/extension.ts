import {
  DocumentSelector,
  executable,
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

  const log = context.logger;
  const selector: DocumentSelector = ["lua"];

  if (executable("stylua")) {
    context.subscriptions.push(
      languages.registerDocumentFormatProvider(
        selector,
        {
          provideDocumentFormattingEdits(textDocument, _, token) {
            const document = workspace.getDocument(textDocument.uri);
            const text = textDocument.getText();
            const activeTextEditor = window.activeTextEditor;

            if (activeTextEditor === void 0) return;

            const folder = workspace.getWorkspaceFolder(
              activeTextEditor.document.uri
            );
            const cwd = folder ? Uri.parse(folder.uri).fsPath : void 0;

            return doFormat(text, cwd)
              .then((result) => {
                if (token.isCancellationRequested) return void 0;

                const endLine = document.lineCount - 1;
                const range = Range.create(
                  { character: 0, line: 0 },
                  { character: document.getline(endLine).length, line: endLine }
                );

                return [TextEdit.replace(range, result)];
              })
              .catch(() => {
                log.warn("stylua format failed");
                return void 0;
              });
          },
        },
        999
      )
    );
  } else {
    window.showInformationMessage("not founded stylua bin in PATH");
  }
}
