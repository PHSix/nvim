"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/extension.ts
var extension_exports = {};
__export(extension_exports, {
  activate: () => activate
});
module.exports = __toCommonJS(extension_exports);
var import_coc = require("coc.nvim");
function getCwd() {
  const uri = import_coc.window.activeTextEditor?.document.uri;
  if (!uri)
    return;
  const cwd = import_coc.workspace.getWorkspaceFolder(uri)?.uri;
  if (cwd)
    return cwd;
  const fsp = import_coc.Uri.parse(uri).fsPath.split("/");
  fsp.pop();
  return fsp.join("/");
}
async function activate(context) {
  context.subscriptions.push(
    import_coc.commands.registerCommand("fzfLua.liveGrep", () => {
      const cwd = getCwd();
      const cmd = "FzfLua live_grep";
      const args = [];
      if (cwd)
        args.push(`cwd=${cwd}`);
      import_coc.nvim.command([cmd, ...args].join(" "));
    }),
    import_coc.commands.registerCommand("fzfLua.findFile", () => {
      const cwd = getCwd();
      const cmd = "FzfLua files";
      const args = [];
      if (cwd)
        args.push(`cwd=${cwd}`);
      import_coc.nvim.command([cmd, ...args].join(" "));
    })
  );
  import_coc.window.onDidChangeActiveTextEditor(() => {
    const uri = import_coc.window.activeTextEditor?.document.uri;
    if (!uri)
      return;
    const folder = import_coc.workspace.getWorkspaceFolder(uri);
    if (!folder)
      return;
    const rootPath = import_coc.Uri.parse(folder.uri).fsPath;
    import_coc.nvim.command(`cd ${rootPath}`);
  });
  setTimeout(() => {
    import_coc.nvim.setKeymap("n", "<leader>ff", "<Cmd>CocCommand fzfLua.findFile<CR>", {
      silent: true,
      noremap: true
    });
    import_coc.nvim.setKeymap("n", "<leader>fw", "<Cmd>CocCommand fzfLua.liveGrep<CR>", {
      silent: true,
      noremap: true
    });
  }, 1e3);
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
