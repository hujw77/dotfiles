local dap = require'dap'
dap.defaults.fallback.terminal_win_cmd = '50vsplit new'
local nvim_lsp = require'lspconfig'
local rt = require'rust-tools'

local function on_attach(client, buffer)
    local keymap_opts = { buffer = buffer, noremap=true, silent=true }
    -- Code navigation and shortcuts
    vim.keymap.set("n" , "<leader>l" , rt.open_cargo_toml.open_cargo_toml , keymap_opts)
    vim.keymap.set("n" , "<leader>m" , rt.expand_macro.expand_macro       , keymap_opts)

    -- Debugging
    vim.keymap.set('n', '<F7>', dap.run_to_cursor, keymap_opts)
    vim.keymap.set('n', '<F8>', dap.continue, keymap_opts)
    vim.keymap.set('n', '<F9>', dap.step_over, keymap_opts)
    vim.keymap.set('n', '<F10>', dap.step_into, keymap_opts)
    vim.keymap.set('n', '<F12>', dap.step_out, keymap_opts)
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, keymap_opts)
    vim.keymap.set('n', '<Leader>B', dap.set_breakpoint, keymap_opts)
    vim.keymap.set('n', '<Leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, keymap_opts)
    vim.keymap.set('n', '<Leader>br', function() dap.repl.open({height=20},"belowright split") end, keymap_opts)
    vim.keymap.set('n', '<Leader>bl', dap.run_last, keymap_opts)
    vim.keymap.set('n', '<Leader>bv', dap.list_breakpoints, keymap_opts)
    vim.keymap.set('n', '<Leader>bc', dap.clear_breakpoints, keymap_opts)
    vim.keymap.set({'n', 'v'}, '<Leader>bp', function()
    	require('dap.ui.widgets').preview()
    end)
end

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local opts = {
    tools = {
	-- how to execute terminal commands
	-- options right now: termopen / quickfix /toggleterm
		executor = require("rust-tools.executors").termopen,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
		-- standalone = true,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = { command = "clippy" },
				-- https://users.rust-lang.org/t/how-to-disable-rust-analyzer-proc-macro-warnings-in-neovim/53150
				procMacro = { enable = true },
			    diagnostics = {
			        enable = true,
			        disabled = {"unresolved-proc-macro"},
			        enableExperimental = true,
			    },
            }
        }
    },
    -- debugging stuff
    -- lldb
    -- dap = {
    --     adapter = {
			-- type = "executable",
			-- command = "/usr/local/opt/llvm/bin/lldb-vscode",
			-- name = "rt_lldb",
			-- stopOnEntry = false,
			-- env = function()
				-- local variables = {}
				-- for k, v in pairs(vim.fn.environ()) do
					-- table.insert(variables, string.format("%s=%s", k, v))
				-- end
				-- return variables
			-- end,
		    -- -- args = {"8", "2"},
		 	-- args = {},
		-- },
	-- },
    -- codelldb
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    },
}

rt.setup(opts)

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
