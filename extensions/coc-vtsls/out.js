"use strict";
var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
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
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/extension.ts
var extension_exports = {};
__export(extension_exports, {
  activate: () => activate
});
module.exports = __toCommonJS(extension_exports);
var import_coc = require("coc.nvim");
var import_node_process = __toESM(require("node:process"));
var supportFiletypes = [
  "javascript",
  "javascript.jsx",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "typescript.tsx"
];
async function showLocations(locations) {
  await import_coc.workspace.showLocations(locations);
}
async function activate(ctx) {
  if (!(0, import_coc.executable)("vtsls")) {
    return;
  }
  const outputChannel = import_coc.window.createOutputChannel("typescript");
  const serverOptions = {
    command: "vtsls",
    args: ["--stdio"],
    options: {
      env: import_node_process.default.env
    }
  };
  const clientOptions = {
    documentSelector: supportFiletypes.map((ft) => ({
      language: ft,
      scheme: "file"
    })),
    outputChannel,
    synchronize: {
      fileEvents: import_coc.workspace.createFileSystemWatcher(
        "{**/*.js,**/*.ts,**/*.jsx,**/*.tsx,**/tsconfig.json,**/jsconfig.json}"
      )
    },
    middleware: {
      workspace: {
        async configuration(params, token, next) {
          const result = await next(params, token);
          const config = result[0] || {};
          if (config.typescript.locale === "auto") {
            let locale = import_node_process.default.env.LANG ? import_node_process.default.env.LANG.split(".")[0] : "en";
            if (locale == "zh_CN")
              locale = "zh-CN";
            else if (locale == "zh_TW")
              locale = "zh-TW";
            config.typescript.locale = locale;
          }
          return [config];
        }
      }
    }
  };
  const client = new import_coc.LanguageClient(
    "vtsls",
    "vtsls",
    serverOptions,
    clientOptions
  );
  ctx.subscriptions.push(import_coc.services.registerLanguageClient(client));
  function executeCommand(args) {
    return client.sendRequest("workspace/executeCommand", args);
  }
  import_coc.commands.registerCommand("vtsls.openLog", () => outputChannel.show());
  import_coc.commands.registerCommand(
    "vtsls.openTsServerLog",
    () => executeCommand({
      command: "typescript.openTsServerLog",
      arguments: []
    })
  );
  import_coc.commands.registerCommand(
    "vtsls.restartTsServer",
    () => executeCommand({
      command: "typescript.restartTsServer",
      arguments: []
    })
  );
  import_coc.commands.registerCommand("vtsls.goToSourceDefinition", async () => {
    const position = await import_coc.window.getCursorPosition();
    const doc = import_coc.window.activeTextEditor?.document;
    if (!doc)
      return;
    if (!supportFiletypes.includes(doc.filetype))
      return;
    const locations = await executeCommand({
      command: "typescript.goToSourceDefinition",
      arguments: [doc.uri, position]
    }).catch(() => []);
    if (!locations || locations.length === 0) {
      import_coc.window.showInformationMessage("Not found source definitions");
    }
    showLocations(locations);
  });
  import_coc.commands.registerCommand("vstls.findAllFileReferences", async () => {
    const doc = import_coc.window.activeTextEditor?.document;
    if (!doc)
      return;
    if (!supportFiletypes.includes(doc.filetype))
      return;
    const locations = await executeCommand({
      command: "typescript.goToSourceDefinition",
      arguments: [doc.uri]
    }).catch(() => []);
    if (!locations || locations.length === 0) {
      import_coc.window.showInformationMessage("Not found file references");
    }
    showLocations(locations);
  });
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
