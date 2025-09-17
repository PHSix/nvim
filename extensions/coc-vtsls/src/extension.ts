import {
  LanguageClient,
  LanguageClientOptions,
  services,
  ServerOptions,
  workspace,
  executable,
  window,
  commands,
  ExtensionContext,
  Location,
} from "coc.nvim";
import process from "node:process";

import {} from "vscode-languageserver-types";

const supportFiletypes = [
  "javascript",
  "javascript.jsx",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
];

// TODO: add bqf support
async function showLocations(locations: Location[]) {
  await workspace.showLocations(locations);
}

export async function activate(ctx: ExtensionContext): Promise<void> {
  if (!executable("vtsls")) {
    return;
  }

  const outputChannel = window.createOutputChannel("typescript");

  const serverOptions: ServerOptions = {
    command: "vtsls",
    args: ["--stdio"],
    options: {
      env: process.env,
    },
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: supportFiletypes.map((ft) => ({
      language: ft,
      scheme: "file",
    })),
    outputChannel,
    synchronize: {
      fileEvents: workspace.createFileSystemWatcher(
        "{**/*.js,**/*.ts,**/*.jsx,**/*.tsx,**/tsconfig.json,**/jsconfig.json}",
      ),
    },
    middleware: {
      workspace: {
        async configuration(params, token, next) {
          const result = await next(params, token);
          const config = result[0] || {};
          if (config.typescript.locale === "auto") {
            let locale = process.env.LANG
              ? process.env.LANG.split(".")[0]
              : "en";

            // for fix zh-CN and zh-TW no in enum error
            if (locale == "zh_CN") locale = "zh-CN";
            else if (locale == "zh_TW") locale = "zh-TW";

            config.typescript.locale = locale;
          }

          return [config];
        },
      },
    },
  };

  const client = new LanguageClient(
    "vtsls",
    "vtsls",
    serverOptions,
    clientOptions,
  );
  ctx.subscriptions.push(services.registerLanguageClient(client));

  function executeCommand<T>(args: any) {
    return client.sendRequest<T>("workspace/executeCommand", args);
  }

  commands.registerCommand("vtsls.openLog", () => outputChannel.show());

  commands.registerCommand("vtsls.openTsServerLog", () =>
    executeCommand({
      command: "typescript.openTsServerLog",
      arguments: [],
    }),
  );
  commands.registerCommand("vtsls.restartTsServer", () =>
    executeCommand({
      command: "typescript.restartTsServer",
      arguments: [],
    }),
  );

  commands.registerCommand("vtsls.goToSourceDefinition", async () => {
    const position = await window.getCursorPosition();
    const doc = window.activeTextEditor?.document;
    if (!doc) return;
    if (!supportFiletypes.includes(doc.filetype)) return;

    const locations = await executeCommand<Location[]>({
      command: "typescript.goToSourceDefinition",
      arguments: [doc.uri, position],
    }).catch(() => []);

    if (!locations || locations.length === 0) {
      window.showInformationMessage("Not found source definitions");
    }

    showLocations(locations);
  });

  commands.registerCommand("vstls.findAllFileReferences", async () => {
    const doc = window.activeTextEditor?.document;
    if (!doc) return;
    if (!supportFiletypes.includes(doc.filetype)) return;

    const locations = await executeCommand<Location[]>({
      command: "typescript.goToSourceDefinition",
      arguments: [doc.uri],
    }).catch(() => []);

    if (!locations || locations.length === 0) {
      window.showInformationMessage("Not found file references");
    }

    showLocations(locations);
  });
}
