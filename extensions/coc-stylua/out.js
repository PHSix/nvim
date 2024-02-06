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
var import_child_process = require("child_process");
var import_path = require("path");
var import_fs = require("fs");
async function doFormat(code, opts = {}) {
  const args = [];
  const { cwd, binPath } = opts;
  if (cwd) {
    await new Promise((res) => {
      const styluaToml = (0, import_path.resolve)(cwd, "stylua.toml");
      (0, import_fs.access)(styluaToml, (err) => {
        if (err === null) {
          args.push("-f", styluaToml);
        }
        res(void 0);
      });
    });
  }
  opts.logger?.info(JSON.stringify(args));
  if (args.length === 0) {
    return void 0;
  }
  args.push("-");
  return new Promise((res, reject) => {
    let result = "";
    const env = !!binPath ? {
      PATH: process.env["PATH"] + `:${absolutePath(binPath)}`
    } : void 0;
    const child = (0, import_child_process.spawn)("stylua", args, {
      cwd,
      env
    });
    child.stdout.on("data", (data) => {
      result += data.toString();
    });
    child.stderr.on("data", (data) => {
      reject(data);
    });
    child.on("error", () => {
      reject("child on error");
    });
    child.stdout.on("close", () => {
      res(result);
    });
    child.stdin.write(code);
    child.stdin.end();
  });
}
function absolutePath(p) {
  if (p.startsWith("~")) {
    return process.env.HOME + p.slice(1);
  }
  return p;
}

// src/extension.ts
async function activate(context) {
  const config = import_coc.workspace.getConfiguration("coc-stylua");
  if (config.get("enabled") === false) {
    return;
  }
  const log = context.logger;
  const selector = ["lua"];
  let enable = true;
  import_coc.workspace.onDidChangeConfiguration(() => {
    const value = import_coc.workspace.getConfiguration().get("coc-stylua.enable");
    if (value) {
      enable = value;
    }
  });
  context.subscriptions.push(
    import_coc.languages.registerDocumentFormatProvider(
      selector,
      {
        provideDocumentFormattingEdits(textDocument, _, token) {
          if (enable === false)
            return;
          const document = import_coc.workspace.getDocument(textDocument.uri);
          const text = textDocument.getText();
          const activeTextEditor = import_coc.window.activeTextEditor;
          if (activeTextEditor === void 0)
            return;
          const folder = import_coc.workspace.getWorkspaceFolder(
            activeTextEditor.document.uri
          );
          const cwd = folder ? import_coc.Uri.parse(folder.uri).fsPath : void 0;
          const binPath = import_coc.workspace.getConfiguration().get("coc-stylua.binPath");
          return doFormat(text, { cwd, binPath, logger: context.logger }).then((result) => {
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
    )
  );
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
