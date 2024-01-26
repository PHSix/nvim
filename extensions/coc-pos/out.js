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

// node_modules/debounce/index.js
var require_debounce = __commonJS({
  "node_modules/debounce/index.js"(exports2, module2) {
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
  activate: () => activate
});
module.exports = __toCommonJS(extension_exports);
var import_coc2 = require("coc.nvim");
var import_debounce = __toESM(require_debounce());

// src/utils.ts
var INVALID_NAMING = /* @__PURE__ */ new Set([
  "index.ts",
  "index.tsx",
  "index.js",
  "index.jsx",
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
  "init.lua"
]);
function getSymbolPath(pos, docuemntSymbols, maxTravelDepth) {
  const result = [];
  let travelDepth = 0;
  let symbols = docuemntSymbols;
  while (symbols !== void 0 && travelDepth < maxTravelDepth) {
    travelDepth++;
    const len = result.length;
    for (const symbol of symbols) {
      if (posInRange(pos, symbol.range)) {
        symbols = symbol.children;
        result.push(symbol);
        break;
      }
    }
    if (len === result.length) {
      return [result, travelDepth];
    }
  }
  return [result, travelDepth];
}
function getFilename(uri) {
  return uri.split("/").pop() || "";
}
function getComponentName(uri) {
  const filePath = uri.split("/").filter((s) => s !== "");
  if (filePath.length === 0)
    return "";
  if (INVALID_NAMING.has(filePath[filePath.length - 1])) {
    return `${filePath[filePath.length - 2]}/${filePath[filePath.length - 1]}`;
  }
  return filePath[filePath.length - 1];
}
function posInRange(pos, range) {
  return (pos.line < range.end.line || pos.line === range.end.line && pos.character <= range.end.character) && (pos.line > range.start.line || pos.line === range.start.line && pos.character >= range.start.character);
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
    symbolLink += ` %#VertSplit#\uF105 %#CocSymbol${key}#${icon}${symbol.name}`;
  }
  return " %#CocSymbolFile#" + prefix + symbolLink;
}

// src/extension.ts
var cancelTokenSource;
function getMaxTravelDepth() {
  const depth = import_coc2.workspace.getConfiguration().get("coc-pos.maxTravelDepth");
  if (typeof depth !== "number" || isNaN(depth)) {
    return 30;
  }
  return depth;
}
async function activate(context) {
  const enabled = import_coc2.workspace.getConfiguration().get("coc-pos.enabled");
  if (enabled === false)
    return;
  let maxTravelDepth = getMaxTravelDepth();
  import_coc2.workspace.onDidChangeConfiguration(() => {
    maxTravelDepth = getMaxTravelDepth();
  });
  const log = context.logger;
  context.subscriptions.push(
    import_coc2.events.on(
      "CursorMoved",
      (0, import_debounce.default)(async (bufnr, cursor) => {
        const document = import_coc2.workspace.getDocument(bufnr);
        if (!document || !document.attached || !document.textDocument || !import_coc2.languages.hasProvider(
          import_coc2.ProviderName.DocumentSymbol,
          document.textDocument
        ))
          return;
        const folderUri = import_coc2.workspace.getWorkspaceFolder(
          document.textDocument.uri
        )?.uri;
        if (!folderUri)
          return;
        cancelTokenSource?.cancel();
        cancelTokenSource?.dispose();
        cancelTokenSource = new import_coc2.CancellationTokenSource();
        const symbols = await import_coc2.languages.getDocumentSymbol(document.textDocument, cancelTokenSource.token);
        if (!symbols)
          return;
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
            import_coc2.Uri.parse(document.uri).fsPath
          );
          const winbar = renderWinbarString(
            !!componentName ? `${filename}:${componentName}` : filename,
            symbolPath
          );
          if ((await import_coc2.nvim.buffer).id === bufnr) {
            import_coc2.nvim.request("nvim_set_option_value", [
              "winbar",
              winbar,
              { scope: "local" }
            ]);
          }
        } catch (err) {
          log.debug(`coc-pos catch some error : ${err.toString()}`);
        }
      }, 70)
    )
  );
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
