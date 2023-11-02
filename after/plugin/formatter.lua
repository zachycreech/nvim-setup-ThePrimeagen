require("conform").setup({
	formatters_by_ft = {
		go = { "golines", "goimports-reviser", "trim_whitespace" },
		lua = { "stylua" },
		javascript = { { "prettierd", "prettier" } },
		javascriptreact = { { "prettierd", "prettier" } },
		typescriptreact = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		["_"] = { "trim_whitespace" },
		["*"] = { "trim_whitespace" },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_fallback = true,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	formatters = {
		my_formatter = {
			command = "my_cmd",
			args = { "--stdin-from-filename", "$FILENAME" },
			range_args = function(ctx)
				return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
			end,
			stdin = true,
			cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
			require_cwd = true,
			condition = function(ctx)
				return vim.fs.basename(ctx.filename) ~= "README.md"
			end,
			exit_codes = { 0, 1 },
			env = {
				VAR = "value",
			},
			inherit = true,
			prepend_args = { "--use-tabs" },
		},
		other_formatter = function(bufnr)
			return {
				command = "my_cmd",
			}
		end,
	},
})
