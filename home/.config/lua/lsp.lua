-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
-- Show diagnostic popup on cursor hover
-- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
-- vim.api.nvim_create_autocmd("CursorHold", {
-- 	callback = function()
-- 		vim.diagnostic.open_float(nil, { focusable = false })
-- 	end,
-- 	group = diag_float_grp,
-- })
-- Goto previous/next diagnostic warning/error
vim.keymap.set('n' , "<leader>e" , vim.diagnostic.open_float , opts)
vim.keymap.set("n" , "<leader>[" , vim.diagnostic.goto_prev  , opts)
vim.keymap.set("n" , "<leader>]" , vim.diagnostic.goto_next  , opts)
vim.keymap.set('n' , "<leader>s" , vim.diagnostic.setloclist , opts)

-- Code navigation and shortcuts
vim.keymap.set("n" , "K"         , vim.lsp.buf.hover            , opts)
vim.keymap.set("n" , "g0"        , vim.lsp.buf.document_symbol  , opts)
vim.keymap.set("n" , "gW"        , vim.lsp.buf.workspace_symbol , opts)
vim.keymap.set("n" , "<c-k>"     , vim.lsp.buf.signature_help   , opts)
vim.keymap.set("n" , "<leader>d" , vim.lsp.buf.definition       , opts)
vim.keymap.set("n" , "<leader>D" , vim.lsp.buf.implementation   , opts)
vim.keymap.set("n" , "<leader>t" , vim.lsp.buf.type_definition  , opts)
vim.keymap.set("n" , "<leader>r" , vim.lsp.buf.references       , opts)
vim.keymap.set("n" , "<leader>c" , vim.lsp.buf.code_action      , opts)

require'lspconfig'.pyright.setup{}
