"use strict";
var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};
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

// node_modules/.pnpm/debounce@2.0.0/node_modules/debounce/index.js
var require_debounce = __commonJS({
  "node_modules/.pnpm/debounce@2.0.0/node_modules/debounce/index.js"(exports2, module2) {
    function debounce2(function_, wait = 100, options = {}) {
      if (typeof function_ !== "function") {
        throw new TypeError(`Expected the first parameter to be a function, got \`${typeof function_}\`.`);
      }
      if (wait < 0) {
        throw new RangeError("`wait` must not be negative.");
      }
      const { immediate } = typeof options === "boolean" ? { immediate: options } : options;
      let storedContext;
      let storedArguments;
      let timeoutId;
      let timestamp;
      let result;
      function later() {
        const last = Date.now() - timestamp;
        if (last < wait && last >= 0) {
          timeoutId = setTimeout(later, wait - last);
        } else {
          timeoutId = void 0;
          if (!immediate) {
            const callContext = storedContext;
            const callArguments = storedArguments;
            storedContext = void 0;
            storedArguments = void 0;
            result = function_.apply(callContext, callArguments);
          }
        }
      }
      const debounced = function(...arguments_) {
        if (storedContext && this !== storedContext) {
          throw new Error("Debounced method called with different contexts.");
        }
        storedContext = this;
        storedArguments = arguments_;
        timestamp = Date.now();
        const callNow = immediate && !timeoutId;
        if (!timeoutId) {
          timeoutId = setTimeout(later, wait);
        }
        if (callNow) {
          const callContext = storedContext;
          const callArguments = storedArguments;
          storedContext = void 0;
          storedArguments = void 0;
          result = function_.apply(callContext, callArguments);
        }
        return result;
      };
      debounced.clear = () => {
        if (!timeoutId) {
          return;
        }
        clearTimeout(timeoutId);
        timeoutId = void 0;
      };
      debounced.flush = () => {
        if (!timeoutId) {
          return;
        }
        const callContext = storedContext;
        const callArguments = storedArguments;
        storedContext = void 0;
        storedArguments = void 0;
        result = function_.apply(callContext, callArguments);
        clearTimeout(timeoutId);
        timeoutId = void 0;
      };
      return debounced;
    }
    module2.exports.debounce = debounce2;
    module2.exports = debounce2;
  }
});

// src/extension.ts
var extension_exports = {};
__export(extension_exports, {
  activate: () => activate,
  deactivate: () => deactivate
});
module.exports = __toCommonJS(extension_exports);
var import_coc2 = require("coc.nvim");
var import_debounce = __toESM(require_debounce());

// src/utils.ts
var invaildFileName = /* @__PURE__ */ new Set([
  "index.ts",
  "index.tsx",
  "index.js",
  "index.jsx",
  "index.vue",
  "index.cjs",
  "index.mjs",
  "index.css",
  "index.less",
  "index.sass",
  "index.scss",
  "index.module.css",
  "index.module.less",
  "index.module.sass",
  "index.module.scss",
  "init.lua",
  "index.d.ts",
  "init.go"
]);
function getSymbolPath(pos, docuemntSymbols, maxTravelDepth2) {
  const result = [];
  let travelDepth = 0;
  let symbols = docuemntSymbols;
  while (symbols !== void 0 && symbols.length !== 0 && travelDepth < maxTravelDepth2) {
    travelDepth++;
    const len = result.length;
    for (const symbol of symbols) {
      if (rangeContain(symbol.range, pos)) {
        symbols = symbol.children;
        result.push(symbol);
        break;
      }
    }
    if (len === result.length)
      return [result, travelDepth];
  }
  return [result, travelDepth];
}
function getFilename(uri) {
  return uri.split("/").pop() || "";
}
function getComponentName(uri) {
  const filePath = uri.split("/").filter((s) => s !== "");
  if (filePath.length === 0)
    return void 0;
  if (invaildFileName.has(filePath[filePath.length - 1]) && filePath.length > 1)
    return `${filePath[filePath.length - 2]}/${filePath[filePath.length - 1]}`;
  return filePath[filePath.length - 1];
}
function rangeContain(range, position) {
  return (position.line < range.end.line || position.line === range.end.line && position.character <= range.end.character) && (position.line > range.start.line || position.line === range.start.line && position.character >= range.start.character);
}

// src/render.ts
var import_coc = require("coc.nvim");
var iconMap = {
  [import_coc.SymbolKind.File]: { icon: "\u{F0219} ", key: "File" },
  [import_coc.SymbolKind.Module]: { icon: "\uE624 ", key: "Module" },
  [import_coc.SymbolKind.Namespace]: { icon: "\u{F0317} ", key: "Namespace" },
  [import_coc.SymbolKind.Package]: { icon: "\uE624 ", key: "Package" },
  [import_coc.SymbolKind.Class]: { icon: "\u{F0317} ", key: "Class" },
  [import_coc.SymbolKind.Method]: { icon: "\u{F01A7} ", key: "Method" },
  [import_coc.SymbolKind.Property]: { icon: "\uE79B ", key: "Property" },
  [import_coc.SymbolKind.Field]: { icon: "\uE716 ", key: "Field" },
  [import_coc.SymbolKind.Constructor]: { icon: "\uF425 ", key: "Constructor" },
  [import_coc.SymbolKind.Enum]: { icon: "\u{F0558} ", key: "Enum" },
  [import_coc.SymbolKind.Interface]: { icon: "\u{F0558} ", key: "Interface" },
  [import_coc.SymbolKind.Function]: { icon: "\u{F0295} ", key: "Function" },
  [import_coc.SymbolKind.Variable]: { icon: "\u{F01A7} ", key: "Variable" },
  [import_coc.SymbolKind.Constant]: { icon: "\u{F03FF} ", key: "Constant" },
  [import_coc.SymbolKind.String]: { icon: "\u{F002C} ", key: "String" },
  [import_coc.SymbolKind.Number]: { icon: "\u{F03A0} ", key: "Number" },
  [import_coc.SymbolKind.Boolean]: { icon: "\u25E9 ", key: "Boolean" },
  [import_coc.SymbolKind.Array]: { icon: "\u{F016A} ", key: "Array" },
  [import_coc.SymbolKind.Object]: { icon: "\u{F0169} ", key: "Object" },
  [import_coc.SymbolKind.Key]: { icon: "\u{F030B} ", key: "Key" },
  [import_coc.SymbolKind.Null]: { icon: "\u{F07E2} ", key: "Null" },
  [import_coc.SymbolKind.EnumMember]: { icon: "\uF15D ", key: "EnumMember" },
  [import_coc.SymbolKind.Struct]: { icon: "\u{F0317} ", key: "Struct" },
  [import_coc.SymbolKind.Event]: { icon: "\uF0E7 ", key: "Event" },
  [import_coc.SymbolKind.Operator]: { icon: "\u{F0195} ", key: "Operator" },
  [import_coc.SymbolKind.TypeParameter]: { icon: "\u{F0284} ", key: "TypeParameter" }
};
function renderWinbarString(prefix, symbolPath) {
  let symbolLink = "";
  for (const symbol of symbolPath) {
    const { icon, key } = iconMap[symbol.kind];
    symbolLink += ` %#VertSplit#\uF105 %#CocSymbol${key}#${icon}${ec(symbol.name)}`;
  }
  return ` %#CocSymbolFile#${ec(prefix)}${symbolLink}%*`;
}
function ec(str) {
  return str.replace("%", "%%");
}

// src/extension.ts
var cancelTokenSource;
var eventDisposable;
var maxTravelDepth;
var symbolsCache = /* @__PURE__ */ new Map();
function getMaxTravelDepth() {
  const depth = import_coc2.workspace.getConfiguration().get("coc-pos.maxTravelDepth");
  if (typeof depth !== "number" || Number.isNaN(depth))
    return 30;
  return depth;
}
function createEventListen(context) {
  maxTravelDepth = getMaxTravelDepth();
  const log = context.logger;
  eventDisposable = import_coc2.events.on(
    "CursorMoved",
    (0, import_debounce.default)(async (bufnr, cursor) => {
      const document = import_coc2.workspace.getDocument(bufnr);
      const win = import_coc2.window.activeTextEditor?.winid !== void 0 ? import_coc2.nvim.createWindow(import_coc2.window.activeTextEditor.winid) : void 0;
      if (!document || !document.attached || !document.textDocument || document.winid === -1 || !win || !await win.valid || await document.buffer.getOption("bufhidden") !== "" || !import_coc2.languages.hasProvider(
        import_coc2.ProviderName.DocumentSymbol,
        document.textDocument
      ))
        return;
      const windowConfig = await win.getConfig();
      if (windowConfig.relative)
        return;
      context.logger.info(windowConfig);
      const folderUri = import_coc2.workspace.getWorkspaceFolder(
        document.textDocument.uri
      )?.uri;
      if (!folderUri)
        return;
      const changedtick = await import_coc2.nvim.call("nvim_buf_get_var", [
        bufnr,
        "changedtick"
      ]);
      let symbols;
      const cache = symbolsCache.get(bufnr);
      if (cache && cache.changedtick === changedtick) {
        symbols = cache.symbols;
      } else {
        cancelTokenSource?.cancel();
        cancelTokenSource?.dispose();
        cancelTokenSource = new import_coc2.CancellationTokenSource();
        const res = await import_coc2.languages.getDocumentSymbol(document.textDocument, cancelTokenSource.token);
        if (!res)
          return;
        symbols = res;
        symbolsCache.set(bufnr, {
          changedtick,
          symbols
        });
      }
      try {
        const [symbolPath] = getSymbolPath(
          {
            line: cursor[0] - 1,
            character: cursor[1] - 1
          },
          symbols,
          maxTravelDepth
        );
        const filename = getFilename(folderUri);
        const componentName = getComponentName(
          document.uri.slice(folderUri.length)
        );
        const winbar = renderWinbarString(
          componentName ? `\uE624 ${filename}:${componentName}` : `\uE624 ${filename}`,
          symbolPath
        );
        if ((await import_coc2.nvim.window).id === win.id) {
          win.setOption("winbar", winbar).catch(
            (err) => {
              log.error(err, winbar);
            }
          );
        }
      } catch (err) {
        log.debug(`coc-pos catch some error : ${err.toString()}`);
      }
    }, 70),
    // delete cache.
    import_coc2.workspace.registerAutocmd({
      event: ["BufDelete", "BufWipeout"],
      pattern: "*",
      callback: (args) => {
        try {
          if (args && args.buf && symbolsCache.has(args.buf))
            symbolsCache.delete(args.buf);
        } catch (err) {
          log.error(Object.toString.call(err));
        }
      }
    })
  );
  context.subscriptions.push(eventDisposable);
}
async function activate(context) {
  const config = import_coc2.workspace.getConfiguration("coc-pos");
  const enable = config.get("enable", true);
  if (enable === true)
    createEventListen(context);
  context.subscriptions.push(import_coc2.workspace.onDidChangeConfiguration((e) => {
    if (e.affectsConfiguration("coc-pos.enable")) {
      if (config.get("enable", true)) {
        createEventListen(context);
      } else {
        eventDisposable?.dispose();
        context.subscriptions = context.subscriptions.filter((s) => s !== eventDisposable);
        for (const buf of symbolsCache.keys()) {
          symbolsCache.delete(buf);
          import_coc2.nvim.request("nvim_set_option_value", ["winbar", "", { buf }]);
        }
      }
    }
    if (e.affectsConfiguration("coc-pos.maxTravelDepth"))
      maxTravelDepth = getMaxTravelDepth();
  }));
}
function deactivate() {
  eventDisposable?.dispose();
  for (const key of symbolsCache.keys())
    symbolsCache.delete(key);
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate,
  deactivate
});
