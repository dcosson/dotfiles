return {
	"selimacerbas/markdown-preview.nvim",
	dependencies = { "selimacerbas/live-server.nvim" },
	config = function()
		local uv = vim.uv or vim.loop
		local PORT_MIN = 8500
		local PORT_MAX = 8999

		local function is_port_available(port)
			local tcp = uv.new_tcp()
			if not tcp then
				return false
			end
			local ok = pcall(tcp.bind, tcp, "127.0.0.1", port)
			tcp:close()
			return ok
		end

		local function pick_random_available_port(min_port, max_port)
			local range = max_port - min_port + 1
			if range <= 0 then
				return nil
			end

			-- Pseudo-randomized scan so each session tends to use a different port.
			local start_offset = (uv.hrtime() % range)
			for i = 0, range - 1 do
				local port = min_port + ((start_offset + i) % range)
				if is_port_available(port) then
					return port
				end
			end

			return nil
		end

		local function force_stop_markdown_preview()
			local ok, mp = pcall(require, "markdown_preview")
			if not ok or not mp then
				return
			end

			local inst = mp._server_instance
			pcall(function()
				mp.stop()
			end)

			if not inst then
				return
			end

			local function safe_close(handle)
				if not handle then
					return
				end
				pcall(function()
					if uv.is_closing and uv.is_closing(handle) then
						return
					end
					handle:close()
				end)
			end

			pcall(function()
				if inst.debounce_timer then
					inst.debounce_timer:stop()
					safe_close(inst.debounce_timer)
				end
			end)
			pcall(function()
				if inst.fs_event then
					inst.fs_event:stop()
					safe_close(inst.fs_event)
				end
			end)
			pcall(function()
				for _, cl in ipairs(inst.sse_clients or {}) do
					safe_close(cl)
				end
				inst.sse_clients = {}
			end)
			safe_close(inst.handle)
			mp._server_instance = nil
		end

		require("markdown_preview").setup({
			-- Chosen dynamically in :MarkdownPreview wrapper below.
			port = PORT_MIN,
			open_browser = true,
			debounce_ms = 300,
		})

		-- Replace the default command with one that picks a fresh available port
		-- whenever a new preview server instance is started.
		pcall(vim.api.nvim_del_user_command, "MarkdownPreview")
		vim.api.nvim_create_user_command("MarkdownPreview", function()
			local mp = require("markdown_preview")
			-- Always restart so switching buffers/files does not require manual stop.
			if mp._server_instance then
				force_stop_markdown_preview()
				mp = require("markdown_preview")
			end

			local port = pick_random_available_port(PORT_MIN, PORT_MAX)
			if not port then
				vim.notify(
					("Markdown Preview: no free ports in range %d-%d"):format(PORT_MIN, PORT_MAX),
					vim.log.levels.ERROR
				)
				return
			end
			mp.config.port = port
			mp.start()
		end, {})

		pcall(vim.api.nvim_del_user_command, "MarkdownPreviewStop")
		vim.api.nvim_create_user_command("MarkdownPreviewStop", function()
			force_stop_markdown_preview()
		end, {})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			group = vim.api.nvim_create_augroup("MarkdownPreviewExitCleanup", { clear = true }),
			callback = function()
				force_stop_markdown_preview()
			end,
			desc = "Stop markdown-preview server on exit",
		})
	end,
}
