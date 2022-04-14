local Job = require("plenary.job")

Job
	:new({
		command =  "curl" ,
		args = { "-fsSL", "-o", "/home/ph/index.html", "https://baidu.com" },
		on_error = function(err)
			print("erro")
		end,
	})
	:sync()
