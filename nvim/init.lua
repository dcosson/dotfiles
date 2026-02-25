require("dcosson.core")
require("dcosson.lazy")

-- Configure in development ai_chat tool
require("intern-ai")
vim.keymap.set("n", "<Leader>a", "<CMD>InternAIToggle<CR>", { desc = "Open the Intern [A]I chat window" })
