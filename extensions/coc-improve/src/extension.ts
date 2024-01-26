import { ExtensionContext, nvim, Uri, window, workspace } from "coc.nvim";

export async function activate(context: ExtensionContext): Promise<void> {
	context.subscriptions.push(
		window.onDidChangeActiveTextEditor((e) => {
			if (e) {
				const folder = workspace.getWorkspaceFolder(e.document.uri);

				if (folder) {
					// context.logger.info(`cd ${Uri.parse(folder.uri).fsPath}`);
					nvim.exec(`cd ${Uri.parse(folder.uri).fsPath}`);
				}
			}
		})
	);
}
