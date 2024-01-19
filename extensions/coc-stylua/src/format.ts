import { spawn } from "child_process";

export async function doFormat(code: string, cwd?: string) {
  return new Promise<string>((resolve, reject) => {
    let result: string = "";
    const child = spawn("stylua", ["-"], {
      cwd,
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
      resolve(result);
    });

    child.stdin.write(code);

    child.stdin.end();
  });
}
