local function on_attach(client, buffer)
    local keymap_opts = { buffer = buffer, noremap=true, silent=true }
    -- Code navigation and shortcuts
    vim.keymap.set("n" , "<leader>d" , vim.lsp.buf.definition       , keymap_opts)
    vim.keymap.set("n" , "K"         , vim.lsp.buf.hover            , keymap_opts)
    vim.keymap.set("n" , "<leader>D" , vim.lsp.buf.implementation   , keymap_opts)
    vim.keymap.set("n" , "<c-k>"     , vim.lsp.buf.signature_help   , keymap_opts)
    vim.keymap.set("n" , "<leader>t" , vim.lsp.buf.type_definition  , keymap_opts)
    vim.keymap.set("n" , "gr"        , vim.lsp.buf.references       , keymap_opts)
    vim.keymap.set("n" , "g0"        , vim.lsp.buf.document_symbol  , keymap_opts)
    vim.keymap.set("n" , "gW"        , vim.lsp.buf.workspace_symbol , keymap_opts)
    vim.keymap.set("n" , "<leader>a" , vim.lsp.buf.code_action      , keymap_opts)

    -- Show diagnostic popup on cursor hover
    local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
      end,
      group = diag_float_grp,
    })
    -- Goto previous/next diagnostic warning/error
    vim.keymap.set("n" , "<leader>[" , vim.diagnostic.goto_prev             , keymap_opts)
    vim.keymap.set("n" , "<leader>]" , vim.diagnostic.goto_next             , keymap_opts)
end

local nvim_lsp = require'lspconfig'

local opts = {
    tools = {
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
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

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
