import { getSymbolPath } from "./utils";

const data = [
  {
    name: "App",
    detail: "",
    kind: 12,
    range: {
      start: { line: 5, character: 0 },
      end: { line: 32, character: 1 },
    },
    selectionRange: {
      start: { line: 5, character: 9 },
      end: { line: 5, character: 12 },
    },
    children: [
      {
        name: "<function>",
        detail: "",
        kind: 12,
        range: {
          start: { line: 20, character: 25 },
          end: { line: 20, character: 61 },
        },
        selectionRange: {
          start: { line: 20, character: 25 },
          end: { line: 20, character: 61 },
        },
        children: [
          {
            name: "setCount() callback",
            detail: "",
            kind: 12,
            range: {
              start: { line: 20, character: 40 },
              end: { line: 20, character: 60 },
            },
            selectionRange: {
              start: { line: 20, character: 40 },
              end: { line: 20, character: 60 },
            },
          },
        ],
      },
      {
        name: "count",
        detail: "",
        kind: 13,
        range: {
          start: { line: 6, character: 9 },
          end: { line: 6, character: 14 },
        },
        selectionRange: {
          start: { line: 6, character: 9 },
          end: { line: 6, character: 14 },
        },
      },
      {
        name: "setCount",
        detail: "",
        kind: 13,
        range: {
          start: { line: 6, character: 16 },
          end: { line: 6, character: 24 },
        },
        selectionRange: {
          start: { line: 6, character: 16 },
          end: { line: 6, character: 24 },
        },
      },
    ],
  },
  {
    name: "default",
    detail: "",
    kind: 13,
    range: {
      start: { line: 34, character: 0 },
      end: { line: 34, character: 18 },
    },
    selectionRange: {
      start: { line: 34, character: 0 },
      end: { line: 34, character: 18 },
    },
  },
];

const result = getSymbolPath(15, 12, data);
console.log(result);
