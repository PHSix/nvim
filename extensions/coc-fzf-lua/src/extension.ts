import {
  commands,
  ExtensionContext,
  nvim,
  Uri,
  window,
  workspace,
} from "coc.nvim";

function getCwd() {
  const uri = window.activeTextEditor?.document.uri;
  if (!uri) return;

  const cwd = workspace.getWorkspaceFolder(uri)?.uri;

  if (cwd) return Uri.parse(cwd).fsPath;

  const fsp = Uri.parse(uri).fsPath.split("/");
  fsp.pop();

  return fsp.join("/");
}

export async function activate(context: ExtensionContext): Promise<void> {
  context.subscriptions.push(
    commands.registerCommand("fzfLua.liveGrep", () => {
      const cwd = getCwd();
      const cmd = "FzfLua live_grep";
      const args: string[] = [];
      if (cwd) args.push(`cwd=${cwd}`);

      nvim.command([cmd, ...args].join(" "));
    }),

    commands.registerCommand("fzfLua.findFile", () => {
      const cwd = getCwd();
      const cmd = "FzfLua files";
      const args: string[] = [];
      if (cwd) args.push(`cwd=${cwd}`);

      nvim.command([cmd, ...args].join(" "));
    }),
  );

  window.onDidChangeActiveTextEditor(() => {
    const uri = window.activeTextEditor?.document.uri;
    if (!uri) return;

    const folder = workspace.getWorkspaceFolder(uri);

    if (!folder) return;
    const rootPath = Uri.parse(folder.uri).fsPath;

    nvim.command(`cd ${rootPath}`);
  });

  setTimeout(() => {
    nvim.setKeymap("n", "<leader>ff", "<Cmd>CocCommand fzfLua.findFile<CR>", {
      silent: true,
      noremap: true,
    });

    nvim.setKeymap("n", "<leader>fw", "<Cmd>CocCommand fzfLua.liveGrep<CR>", {
      silent: true,
      noremap: true,
    });
  }, 1000);
}
