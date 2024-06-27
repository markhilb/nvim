return {
	"phaazon/hop.nvim",
	config = function()
		local hop = require("hop")

		hop.setup({ keys = "qgmlwbyuvdstnriaeohzxcfjkp" })

		vim.keymap.set({ "n", "v" }, "r", hop.hint_char1)
	end,
}
