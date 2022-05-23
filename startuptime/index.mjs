import { renameSync, writeFileSync } from "fs";
import { exec, execSync } from "child_process";

const cwd = process.cwd();

(async () => {
	const nfOutput = execSync("neofetch --stdout");
	const output = nfOutput.toString();
	console.log("Has get your system message.")
	console.log(output)
	writeFileSync(`${cwd}/time.txt`, output);

	const cmd = exec(`nvim --startuptime ${cwd}/time.txt`);
	console.log("Start get neovim startup time message.")
	await new Promise((resolve) => {
		setTimeout(() => {
			resolve(null);
		}, 1000);
	});
	const now = new Date();
	cmd.kill();
	console.log("Renameing file ...")
	renameSync(
		`${cwd}/time.txt`,
		`${cwd}/${now.getFullYear()}-${
			now.getMonth() + 1
		}-${now.getDate()}-${now.getHours()}-${now.getMinutes()}.txt`
	);
})();
