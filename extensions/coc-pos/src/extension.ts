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
	nvim,
	Uri,
} from "coc.nvim";
import debounce from "debounce";
import { getComponentName, getFilename, getSymbolPath } from "./utils";
import { renderWinbarString } from "./render";

interface GetSymbolable {
	getDocumentSymbol(
		document: TextDocument,
		token: CancellationToken
	): Promise<DocumentSymbol[] | null>;
}

let cancelTokenSource: CancellationTokenSource;

function getMaxTravelDepth() {
	const depth = workspace
		.getConfiguration()
		.get<number>("coc-pos.maxTravelDepth");
	if (typeof depth !== "number" || isNaN(depth)) {
		return 30;
	}

	return depth;
}

export async function activate(context: ExtensionContext): Promise<void> {
	const enabled = workspace.getConfiguration().get("coc-pos.enabled");

	if (enabled === false) return;

	let maxTravelDepth = getMaxTravelDepth();

	workspace.onDidChangeConfiguration(() => {
		maxTravelDepth = getMaxTravelDepth();
	});

	const log = context.logger;

	const symbolsCache = new Map<
		number,
		{
			changedtick: number;
			symbols: DocumentSymbol[];
		}
	>();

	context.subscriptions.push(
		events.on(
			"CursorMoved",
			debounce(async (bufnr: number, cursor: [number, number]) => {
				const document = workspace.getDocument(bufnr);

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

				const folderUri = workspace.getWorkspaceFolder(
					document.textDocument.uri
				)?.uri;

				if (!folderUri) return;

				const changedtick = await nvim.call("nvim_buf_get_var", [
					bufnr,
					"changedtick",
				]);

				let symbols: DocumentSymbol[];

				const cache = symbolsCache.get(bufnr);

				if (cache && cache.changedtick === changedtick) {
					symbols = cache.symbols;
				} else {
					cancelTokenSource?.cancel();
					cancelTokenSource?.dispose();
					cancelTokenSource = new CancellationTokenSource();

					const res = await (
						languages as any as GetSymbolable
					).getDocumentSymbol(document.textDocument, cancelTokenSource.token);

					if (!res) return;

					symbols = res;

					symbolsCache.set(bufnr, {
						changedtick,
						symbols,
					});
				}

				try {
					const [symbolPath] = getSymbolPath(
						{
							line: cursor[0] - 1,
							character: cursor[1] - 1,
						},
						symbols,
						maxTravelDepth
					);
					const filename = getFilename(folderUri);
					const componentName = getComponentName(
						Uri.parse(document.uri).fsPath
					);

					const winbar = renderWinbarString(
						!!componentName ? `${filename}:${componentName}` : filename,
						symbolPath
					);

					if ((await nvim.buffer).id === bufnr) {
						nvim.request("nvim_set_option_value", [
							"winbar",
							winbar,
							{ scope: "local" },
						]);
					}
				} catch (err: any) {
					log.debug(`coc-pos catch some error : ${err.toString()}`);
				}
			}, 70),
			workspace.registerAutocmd({
				event: ["BufDelete", "BufWipeout"],
				pattern: "*",
				callback: (args: any) => {
					try {
						if (args && args.buf && symbolsCache.has(args.buf)) {
							symbolsCache.delete(args.buf);
						}
					} catch (err) {
						log.error(Object.toString.call(err));
					}
				},
			})
		)
	);
}
