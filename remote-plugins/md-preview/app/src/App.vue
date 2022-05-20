<script setup lang="ts">
import { io } from "socket.io-client";
import { onMounted } from "vue";
onMounted(() => {
	const conn = io("http://localhost:5000");
	conn.on("created", function () {
		console.log("socket.io has connect");
	});
});
</script>

<template>
	<main>
		<div class="md-preview-container"></div>
	</main>
</template>

<style>
* {
	margin: 0;
	padding: 0;
}

main {
	background-color: #e2e8f0;
	min-height: 100vh;
	width: 100vw;
	display: flex;
	justify-content: center;
	align-items: center;
	box-sizing: border-box;
}
.md-preview-container {
	border-radius: 1rem;
	border: 2px solid #fff;
	background-color: #fff;
	min-height: 70vh;
	width: 60vw;
}
</style>
