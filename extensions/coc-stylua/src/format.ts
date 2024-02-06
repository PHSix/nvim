import { spawn } from "child_process";
import { resolve } from "path";
import { access } from "fs";
import { Logger } from "coc.nvim";

export async function doFormat(
  code: string,
  opts: {
    cwd?: string;
    binPath?: string;
    logger?: Logger;
  } = {}
) {
  const args: string[] = [];
  const { cwd, binPath } = opts;

  if (cwd) {
    await new Promise((res) => {
      const styluaToml = resolve(cwd, "stylua.toml");
      access(styluaToml, (err) => {
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

  return new Promise<string>((res, reject) => {
    let result: string = "";
    const env = !!binPath
      ? {
          PATH: process.env["PATH"] + `:${absolutePath(binPath)}`,
        }
      : void 0;

    const child = spawn("stylua", args, {
      cwd,
      env,
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

function absolutePath(p: string) {
  if (p.startsWith("~")) {
    return process.env.HOME + p.slice(1);
  }

  return p;
}
