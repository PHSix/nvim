import { LanguageClient } from "coc.nvim";

// TODO:
export default class JsxClosingTag {
  private static instance: JsxClosingTag | null = null;
  constructor(private client: LanguageClient) {
    this.init();
  }

  init() {}

  static register(client: LanguageClient) {
    if (JsxClosingTag.instance) return;
    JsxClosingTag.instance = new JsxClosingTag(client);
  }
}
