import {
	CancellationToken,
	CancellationTokenSource,
	ExtensionContext,
	Location,
	Position,
	ProviderName,
	Range,
	TextDocument,
	Uri,
	commands,
	languages,
	nvim,
	window,
	workspace,
	Buffer,
} from "coc.nvim";

export interface LocationWithTarget extends Location {
	/**
	 * The full target range of this link. If the target for example is a symbol then target range is the
	 * range enclosing this symbol not including leading/trailing whitespace but everything else like comments. This information is typically used to highlight the range in the editor.
	 */
	targetRange?: Range;
}

interface GetDefinition {
	getDefinition(
		document: TextDocument,
		position: Position,
		token: CancellationToken
	): Promise<LocationWithTarget[]>;
}

let cancellationTokenSource: CancellationTokenSource;

export async function activate(context: ExtensionContext): Promise<void> {
	context.subscriptions.push(
		commands.registerCommand("coc-peek.peek-definition", async () => {
			const [buffer, position] = await Promise.all([
				nvim.buffer,
				window.getCursorPosition(),
			]);

			const document = workspace.getDocument(buffer.id);

			if (languages.hasProvider(ProviderName.Definition, document)) {
				// not provide
				return;
			}

			cancellationTokenSource = new CancellationTokenSource();

			const locations = await (languages as any as GetDefinition).getDefinition(
				document.textDocument,
				position,
				cancellationTokenSource.token
			);

			if (locations.length === 0) {
				// error handle
				return;
			}

			const fsPath = Uri.parse(locations[0].uri).fsPath;

			const previewBuffer = await createPreviewBuffer();

			const w = await nvim.openFloatWindow(buffer, false, {
				height: 10,
				width: 20,
				row: 10,
				col: 10,
			});

			w.request("nvim_win_set_buf", [w.id, previewBuffer.id]);

			// workspace.openTextDocument()
			// locations[0].uri;
		})
	);
}

let buffer: Buffer;
async function createPreviewBuffer() {
	if (buffer === void 0) {
		buffer = await nvim.createNewBuffer(true, true);
	}

	if ((await buffer.valid) === false) {
		buffer = await nvim.createNewBuffer(true, true);
	}

	return buffer;
}
