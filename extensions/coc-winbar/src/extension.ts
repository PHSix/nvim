import {
  CancellationToken,
  CancellationTokenSource,
  DocumentSymbol,
  ExtensionContext,
  ProviderName,
  TextDocument,
  events,
  languages,
  workspace,
} from "coc.nvim";
import debounce from "debounce";
import { getSymbolPath } from "./utils";

interface GetSymbolable {
  getDocumentSymbol(
    document: TextDocument,
    token: CancellationToken
  ): Promise<DocumentSymbol[] | null>;
}

let cancelTokenSource: CancellationTokenSource;

export async function activate(context: ExtensionContext): Promise<void> {
  const log = context.logger;
  context.subscriptions.push(
    events.on(
      "CursorMoved",
      debounce(async (bufnr, cursor) => {
        const document = workspace.getDocument(bufnr);
        // const document = window.activeTextEditor?.document;
        if (
          !document ||
          !document.attached ||
          !document.textDocument ||
          !languages.hasProvider(
            ProviderName.DocumentSymbol,
            document.textDocument
          )
        )
          return;

        cancelTokenSource?.cancel();
        cancelTokenSource = new CancellationTokenSource();

        const symbols = await (
          languages as any as GetSymbolable
        ).getDocumentSymbol(document.textDocument, cancelTokenSource.token);

        if (!symbols) return;

        try {
          const symbolPath = getSymbolPath(
            cursor[0] - 1,
            cursor[1] - 1,
            symbols
          ).map((symbol) => ({
            kind: symbol.kind,
            name: symbol.name,
          }));

          log.info(
            `getSymbolPath result: ${JSON.stringify(
              symbolPath.map((r) => ({
                name: r.name,
                kind: r.kind,
              }))
            )}`
          );
          // log.info(`getSymbolPath pattern: ${JSON.stringify(symbols)}`);
        } catch (err: any) {
          log.debug(`winbar catch some error : ${err.toString()}`);
        }
      }, 100)
    )
  );
}
