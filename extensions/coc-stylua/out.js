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

// src/format.ts
var import_node_child_process = require("node:child_process");
var import_node_path = require("node:path");
var import_node_fs = require("node:fs");
async function doFormat(code, opts = {}) {
  const args = [];
  const { cwd } = opts;
  if (cwd) {
    await new Promise((res) => {
      const styluaToml = (0, import_node_path.resolve)(cwd, "stylua.toml");
      (0, import_node_fs.access)(styluaToml, (err) => {
        if (err === null)
          args.push("-f", styluaToml);
        res(void 0);
      });
    });
  }
  opts.logger?.info(JSON.stringify(args));
  if (args.length === 0)
    return void 0;
  args.push("-");
  return new Promise((res, reject) => {
    let result = "";
    const child = (0, import_node_child_process.spawn)("stylua", args, {
      cwd
    });
    child.stdout.on("data", (data) => {
      result += data.toString();
    });
    child.stderr.on("data", (data) => {
      reject(data);
    });
    child.on("error", () => {
      reject(Error("child on error"));
    });
    child.stdout.on("close", () => {
      res(result);
    });
    child.stdin.write(code);
    child.stdin.end();
  });
}

// src/extension.ts
async function activate(context) {
  const config = import_coc.workspace.getConfiguration("coc-stylua");
  if (config.get("enable") === false || (0, import_coc.executable)("stylua") === false)
    return;
  const selector = ["lua"];
  let provider;
  function registerProvider() {
    provider = import_coc.languages.registerDocumentFormatProvider(
      selector,
      {
        provideDocumentFormattingEdits(textDocument, _, token) {
          const document = import_coc.workspace.getDocument(textDocument.uri);
          const text = textDocument.getText();
          const activeTextEditor = import_coc.window.activeTextEditor;
          if (activeTextEditor === void 0)
            return;
          const folder = import_coc.workspace.getWorkspaceFolder(
            activeTextEditor.document.uri
          );
          const cwd = folder ? import_coc.Uri.parse(folder.uri).fsPath : void 0;
          return doFormat(text, { cwd, logger: context.logger }).then((result) => {
            if (result === void 0)
              return void 0;
            if (token.isCancellationRequested)
              return void 0;
            const endLine = document.lineCount - 1;
            const range = import_coc.Range.create(
              { character: 0, line: 0 },
              {
                character: document.getline(endLine).length,
                line: endLine
              }
            );
            return [import_coc.TextEdit.replace(range, result)];
          }).catch((err) => {
            import_coc.window.showErrorMessage(Object.toString.call(err));
            return void 0;
          });
        }
      },
      999
    );
  }
  import_coc.workspace.onDidChangeConfiguration(() => {
    const value = import_coc.workspace.getConfiguration().get("coc-stylua.enable");
    if (value && !provider) {
      registerProvider();
      context.subscriptions = [provider];
    } else {
      provider?.dispose();
      provider = void 0;
      context.subscriptions = [];
    }
  });
  registerProvider();
  context.subscriptions = [provider];
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
