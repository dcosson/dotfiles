return {
	{
		"nvim-lua/plenary.nvim",
		config = function()
			-- Setup some shortcuts that rely on plenary
			local Job = require("plenary.job")
			-- shell_cmd should return a list of files in the workspace, those will be opened in new buffers

			local function split_string_on_newlines(text)
				local lines = {}
				local last_i = 1
				for i = 1, #text do
					if text:sub(i, i) == "\n" then
						table.insert(lines, text:sub(last_i, i - 1))
						last_i = i + 1
					end
				end
				local last_line = text:sub(last_i, #text)
				table.insert(lines, last_line)
				return lines
			end

			local function pyright_workspace_check()
				local timeout_ms = 15000
				Job:new({
					command = "pyright",
					args = { "--outputjson" },
					on_exit = function(j, return_val)
						if return_val == 0 then
							print("SUCESS: No pyright errors in workspace")
						elseif return_val == 1 then
							local raw_value = table.concat(j:result(), "\n")
							local value = vim.json.decode(raw_value)
							local diagnostics = value["generalDiagnostics"]
							table.sort(diagnostics, function(a, b)
								return a["file"] < b["file"]
							end)
							local files = {}
							local prev_file = nil
							for i, obj in ipairs(diagnostics) do
								if obj["file"] ~= prev_file then
									table.insert(files, obj["file"])
								end
								prev_file = obj["file"]
							end

							local num_errors = value["summary"]["errorCount"]
							local num_warnings = value["summary"]["warningCount"]
							print(
								"Pyright found "
									.. num_errors
									.. " errors and "
									.. num_warnings
									.. " warnings in "
									.. #files
									.. " files."
							)

							local first_few_files = {}
							local rest_of_files = {}
							for i, file in ipairs(files) do
								if i <= 5 then
									table.insert(first_few_files, file)
								else
									table.insert(rest_of_files, file)
								end
							end

							-- Open the first few files slowly so the user can see what's happening,
							-- but if there are a lot of files to open load the rest all at once
							for i, file in ipairs(files) do
								vim.defer_fn(function()
									vim.api.nvim_command("edit " .. file)
								end, i * 500)
							end
							vim.schedule(function()
								for _, file in ipairs(rest_of_files) do
									vim.api.nvim_command("edit " .. file)
								end
							end)
						else
							print("ERROR - got unexpected pyright return value " .. return_val)
						end
					end,
				}):sync(timeout_ms)
			end
			vim.api.nvim_create_user_command("WorkspaceCheckPyrightErrors", pyright_workspace_check, {})
		end,
	},
}
