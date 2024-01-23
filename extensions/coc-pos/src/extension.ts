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
} from "coc.nvim";
import debounce from "debounce";
import { getFilename, getSymbolPath } from "./utils";
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

				cancelTokenSource?.cancel();
				cancelTokenSource?.dispose();
				cancelTokenSource = new CancellationTokenSource();

				const symbols = await (
					languages as any as GetSymbolable
				).getDocumentSymbol(document.textDocument, cancelTokenSource.token);

				if (!symbols) return;

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

					const winbar = renderWinbarString(filename, symbolPath);

					nvim.request("nvim_set_option_value", [
						"winbar",
						winbar,
						{ buf: bufnr },
					]);
				} catch (err: any) {
					log.debug(`coc-pos catch some error : ${err.toString()}`);
				}
			}, 70)
		)
	);
}
