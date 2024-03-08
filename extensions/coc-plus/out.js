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
async function activate(context) {
  context.subscriptions.push(
    import_coc.window.onDidChangeActiveTextEditor(async (e) => {
      if (e) {
        const folder = import_coc.workspace.getWorkspaceFolder(e.document.uri);
        if (!folder)
          return;
        const workspacePath = import_coc.Uri.parse(folder.uri).fsPath;
        const cwd = await import_coc.nvim.call("getcwd");
        if (workspacePath === cwd) {
          return;
        }
        if (workspacePath.includes(cwd)) {
          const etcPath = workspacePath.slice(cwd.length);
          if (etcPath.split("/").every((item) => !item.startsWith("."))) {
            return;
          }
        }
        import_coc.nvim.exec(`cd ${workspacePath}`);
      }
    })
  );
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
