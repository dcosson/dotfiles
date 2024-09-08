return {
	"nvim-lua/plenary.nvim",
	config = function()
		-- Setup some shortcuts that rely on plenary
		local Job = require("plenary.job")
		-- shell_cmd should return a list of files in the workspace, those will be opened in new buffers

		local options = {
			checkers = {
				"pyright",
			},
			checker_config = {
				pyright = {
					command = "pyright",
					command_args = { "--outputjson" },
					timeout = 5000,
					parse_result = function(exit_code, result_val)
						-- Function that takes:
						--   exit_code: int
						--   result_val: table, a list of the output lines
						-- Return:
						--   success_message: str or nil. Optional, if no errors returned then will show a default success message.
						--   error_message: str or nil.  Optional, if errors are returned and this is blank will show a default error summary message.
						--   num_errors: int or nil. Optional, total number of errors.
						--   num_warnings: int or nil. Optional, total number of warnings.
						--   error_files_list: table, array of strings of the paths that have errors or warnings
						if exit_code == 0 then
							return { "No pyright errors in workspace.", nil, nil, nil, {} }
						elseif exit_code == 1 then
							local result = vim.json.decode(table.concat(result_val, ""))
							local files = {}
							for _, obj in ipairs(result["generalDiagnostics"]) do
								table.insert(files, obj["file"])
							end
							return {
								nil,
								nil,
								result["summary"]["errorCount"],
								result["summary"]["warningCount"],
								files,
							}
						else
							return {
								nil,
								"Running `pyright --outputjson` unexepectedly returned " .. exit_code,
								nil,
								nil,
								{},
							}
						end
					end,
				},
			},
		}

		local function setup_workspace_check(checker_name, command, command_args, parse_result, timeout)
			local slow_open_num = 5
			local slow_open_timeout = 500
			return function()
				Job:new({
					command = command,
					args = command_args,
					on_exit = function(j, return_val)
						local success_message, error_message, num_errors, num_warnings, error_files_list =
							unpack(parse_result(return_val, j:result()))
						if #error_files_list == 0 then
							if error_message ~= nil and string.len(error_message) > 0 then
								-- no error files returned but error message, means something went wrong running the checker
								print("ERROR: " .. error_message)
							else
								if success_message == nil or string.len(success_message) == 0 then
									success_message = "No " .. checker_name .. " errors in workspace"
								end
								print("SUCCESS: " .. success_message)
							end
							return
						end

						local first_few_files = {}
						local rest_of_files = {}
						table.sort(error_files_list)
						local prev_file = nil
						for _, file in ipairs(error_files_list) do
							if file ~= prev_file then
								if slow_open_num ~= nil and #first_few_files < slow_open_num then
									table.insert(first_few_files, file)
								else
									table.insert(rest_of_files, file)
								end
								prev_file = file
							end
						end

						if error_message == nil or string.len(error_message) == 0 then
							error_message = checker_name .. " found "
							if num_errors ~= nil then
								error_message = error_message .. num_errors .. " errors "
								if num_warnings ~= nil then
									error_message = error_message .. "and " .. num_warnings .. " warnings "
								end
							else
								error_message = error_message .. #error_files_list .. " issues "
							end
							error_message = error_message .. "in " .. #first_few_files + #rest_of_files .. " files"
						end
						print("ERROR: " .. error_message)

						-- Open the first few files slowly so the user can see what's happening,
						-- but if there are a lot of files to open load the rest all at once
						for i, file in ipairs(first_few_files) do
							vim.defer_fn(function()
								vim.api.nvim_command("edit " .. file)
							end, i * slow_open_timeout)
						end
						vim.schedule(function()
							for _, file in ipairs(rest_of_files) do
								vim.api.nvim_command("edit " .. file)
							end
						end)
					end,
				}):sync(timeout)
			end
		end

		local function setup(opts)
			local config
			local configured_checks = {}
			for _, checker in ipairs(opts["checkers"]) do
				config = opts["checker_config"][checker]
				configured_checks[checker] = setup_workspace_check(
					checker,
					config["command"],
					config["command_args"],
					config["parse_result"],
					config["timeout"]
				)
			end

			local function capitalize(str)
				if string.len(str) == 0 then
					return str
				elseif string.len(str) == 1 then
					return string.upper(str)
				else
					return string.sub(str, 1, 1):upper() .. string.sub(str, 2):lower()
				end
			end

			for checker_name, check_fn in pairs(configured_checks) do
				local user_command_name = "WorkspaceCheck" .. capitalize(checker_name) .. "Errors"
				vim.api.nvim_create_user_command(user_command_name, check_fn, {})
			end
		end

		setup(options)
	end,
}
