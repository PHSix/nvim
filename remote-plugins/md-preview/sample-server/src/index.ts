import { Server } from "socket.io";
import { readFileSync } from "fs";
import http from "http";

const app = http.createServer();

const io = new Server(app, {
	cors: {
		origin: ["http://localhost:3000"],
		allowedHeaders: [],
		credentials: true,
	},
});

io.on("connection", (socket) => {
	socket.emit("created", "hello world");
	setTimeout(() => {
		const buf = readFileSync("./temp.md");
		const body = buf.toString();
		socket.emit("mdInit", body);
	}, 1000);
});

io.listen(5000);
