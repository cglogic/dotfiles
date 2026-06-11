-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options
local env = vim.env  -- to work with env vars

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = ','

local border = 'single'

-------------------- OPTIONS -------------------------------
opt.modeline = false                   -- Disable modeline
opt.background = 'dark'           -- or "light" for light mode
cmd 'colorscheme retrobox'
-- cmd 'colorscheme base16-tomorrow-night'-- Put your favorite colorscheme here
-- cmd 'colorscheme tomorrow-night'    -- Put your favorite colorscheme here
opt.winborder = border
-- opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.completeopt = {'menuone', 'noselect'}  -- Completion options
-- opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
-- opt.ignorecase = true               -- Ignore case
-- opt.joinspaces = false              -- No double spaces with join
opt.list = true                     -- Show some invisible characters
opt.listchars = { tab = '→ ', extends = '⟩', precedes = '⟨', trail = '•', nbsp = '␣' }
opt.number = true                   -- Show line numbers
-- opt.relativenumber = true           -- Relative line numbers
-- opt.scrolloff = 4                   -- Lines of context
-- opt.shiftround = true               -- Round indent
opt.shiftwidth = 4                  -- Size of an indent
-- opt.sidescrolloff = 8               -- Columns of context
opt.smartcase = true                -- Do not ignore case with capitals
opt.smartindent = true              -- Insert indents automatically
-- opt.splitbelow = true               -- Put new windows below current
-- opt.splitright = true               -- Put new windows right of current
opt.tabstop = 4                     -- Number of spaces tabs count for
opt.termguicolors = true            -- True color support
-- opt.wildmode = {'list', 'longest'}  -- Command-line completion mode
opt.wrap = false                    -- Disable line wrap
opt.mouse = ''                      -- Disable mouse

if env.WAYLAND_DISPLAY ~= nil then
	opt.clipboard = 'unnamedplus'       -- Use wayland clipboard
end

vim.api.nvim_command [[match errorMsg /\s\+$/]]

-- vim.api.nvim_set_hl(0, "Delimiter", { fg = "#0000ff" })

-------------------- MAPPINGS ------------------------------
map('n', ';', ':')  -- Map ; -> :

-- map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
-- map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
-- map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

-- map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
-- map('n', '<leader>o', 'm`o<Esc>``')  -- Insert a newline in normal mode

-- Shift + J/K moves selected lines down/up in visual mode
-- map("i", "<C-h>", "<Esc>:m .+1<CR>==gi", cmd_options)
-- map("i", "<C-j>", "<Esc>:m .-2<CR>==gi", cmd_options)

------------------------------------------------------------
vim.keymap.set('n', '<space>,', function()
  vim.diagnostic.jump({ count = -1, float = true })
end)

vim.keymap.set('n', '<space>;', function()
  vim.diagnostic.jump({ count = 1, float = true })
end)

-- map('n', '<space>,', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- map('n', '<space>;', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

vim.diagnostic.config {
	virtual_text = false,
	signs = false,
	underline = true,
	float = {
		show_header = true,
		source = 'if_many',
		border = border,
		focusable = false,
	},
}

vim.lsp.buf.hover({ border = border })

-------------------- COMMANDS ------------------------------

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

--------------------------------------------------------------------

vim.keymap.set("n", "<leader>o", ":copen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>c", ":cclose<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", ":cprev<CR>", { noremap = true, silent = true })
