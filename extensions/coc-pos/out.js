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
var import_coc = require("coc.nvim");
var import_debounce = __toESM(require_debounce());

// src/utils.ts
function getSymbolPath(row, col, symbols, result = [], depth = 0) {
  if (depth === 100) {
    throw Error("getPath too depth");
  }
  for (const symbol of symbols) {
    switch (true) {
      case (symbol.range.start.line < row && symbol.range.end.line > row): {
        result.push(symbol);
        return !!symbol.children ? getSymbolPath(row, col, symbol.children, result, depth + 1) : result;
      }
      case symbol.range.start.line === symbol.range.end.line: {
        if (col >= symbol.range.start.character && col <= symbol.range.end.character) {
          return !!symbol.children ? getSymbolPath(row, col, symbol.children, result, depth + 1) : result;
        }
        break;
      }
      case symbol.range.start.line === row: {
        if (col >= symbol.range.start.character) {
          return !!symbol.children ? getSymbolPath(row, col, symbol.children, result, depth + 1) : result;
        }
        break;
      }
      case symbol.range.end.line === row: {
        if (col <= symbol.range.end.character) {
          return !!symbol.children ? getSymbolPath(row, col, symbol.children, result, depth + 1) : result;
        }
        break;
      }
    }
  }
  return result;
}
function getFilename(uri) {
  return uri.split("/").pop() || "";
}

// src/extension.ts
var cancelTokenSource;
async function activate(context) {
  const log = context.logger;
  context.subscriptions.push(
    import_coc.events.on(
      "CursorMoved",
      (0, import_debounce.default)(async (bufnr, cursor) => {
        const document = import_coc.workspace.getDocument(bufnr);
        if (!document || !document.attached || !document.textDocument || !import_coc.languages.hasProvider(
          import_coc.ProviderName.DocumentSymbol,
          document.textDocument
        ))
          return;
        cancelTokenSource?.cancel();
        cancelTokenSource = new import_coc.CancellationTokenSource();
        const symbols = await import_coc.languages.getDocumentSymbol(document.textDocument, cancelTokenSource.token);
        if (!symbols)
          return;
        try {
          const symbolPath = getSymbolPath(
            cursor[0] - 1,
            cursor[1] - 1,
            symbols
          ).map((symbol) => ({
            kind: symbol.kind,
            name: symbol.name
          }));
          const filename = getFilename(document.textDocument.uri);
          const winbarPrefix = `%#WinBar%#WinBarPrefix %*#WinBarFilename ${filename} %*`;
          log.info(
            `getSymbolPath result: ${JSON.stringify(
              symbolPath.map((r) => ({
                name: r.name,
                kind: r.kind
              }))
            )}`
          );
          const winbar = symbolPath.reduce((winbar2, symbol) => {
            return winbar2 + `%#WinBarSep A %* ${symbol.name} `;
          }, winbarPrefix);
          log.info(winbar);
        } catch (err) {
          log.debug(`winbar catch some error : ${err.toString()}`);
        }
      }, 100)
    )
  );
}
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
