import {
  ExtensionContext,
  nvim,
  Uri,
  window,
  workspace,
} from "coc.nvim";

export async function activate(context: ExtensionContext): Promise<void> {
  context.subscriptions.push(
    window.onDidChangeActiveTextEditor(async (e) => {
      if (e) {
        const folder = workspace.getWorkspaceFolder(e.document.uri);
        if (!folder) return;
        const workspacePath = Uri.parse(folder.uri).fsPath;
        const cwd = (await nvim.call("getcwd")) as string;

        if (workspacePath === cwd) {
          return;
        }

        if (workspacePath.includes(cwd)) {
          const etcPath = workspacePath.slice(cwd.length);
          if (etcPath.split("/").every((item) => !item.startsWith("."))) {
            return;
          }
        }

        nvim.exec(`cd ${workspacePath}`);
      }
    })
  );
}
