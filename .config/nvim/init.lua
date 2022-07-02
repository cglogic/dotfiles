-------------------- HELPERS -------------------------------
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = ","

-------------------- PLUGINS -------------------------------
require "paq" {
	'savq/paq-nvim';  -- paq-nvim manages itself

	-- 'kyazdani42/nvim-web-devicons';
	'hoob3rt/lualine.nvim';
	'RRethy/nvim-base16';
	'nvim-treesitter/nvim-treesitter';
	-- 'neovim/nvim-lspconfig';
	-- 'hrsh7th/cmp-nvim-lsp';
	-- 'hrsh7th/cmp-buffer';
	-- 'hrsh7th/nvim-cmp';
	'ibhagwan/fzf-lua';
	'lewis6991/spaceless.nvim';
	'terrortylor/nvim-comment';
	'Everduin94/nvim-quick-switcher';
}

-------------------- OPTIONS -------------------------------
vim.o.background = 'dark'           -- or "light" for light mode
-- cmd 'colorscheme base16'           -- Put your favorite colorscheme here
-- opt.completeopt = {'menuone', 'noinsert', 'noselect'}  -- Completion options
opt.completeopt = {'menuone', 'noselect'}  -- Completion options
-- opt.expandtab = true                -- Use spaces instead of tabs
opt.hidden = true                   -- Enable background buffers
-- opt.ignorecase = true               -- Ignore case
-- opt.joinspaces = false              -- No double spaces with join
-- opt.list = true                     -- Show some invisible characters
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
vim.cmd('colorscheme base16-tomorrow-night')

require('lualine').setup {
	options = {
		icons_enabled = false,
		-- theme = 'tokyonight',
		-- section_separators = {'', ''},
		-- component_separators = {'', ''},
		section_separators = '',
		component_separators = ''
	}
}

-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {
	-- ensure_installed = 'maintained',
	ensure_installed = { "c", "cpp", "python", "json", "lua", "markdown", "ninja", "regex", "vim" },
	highlight = {
		enable = true
	}
}

-------------------- LSP -----------------------------------
-- local lsp = require 'lspconfig'
-- -- local lspfuzzy = require 'lspfuzzy'

-- -- For ccls we use the default settings
-- lsp.ccls.setup {}
-- -- root_dir is where the LSP server will start: here at the project root otherwise in current folder
-- -- lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd())}
-- lsp.pylsp.setup {}
-- -- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

-- -- map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
-- -- map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
-- -- map('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- -- map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
-- -- map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
-- -- map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- -- map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
-- -- map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
-- -- map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

------------------------------------------------------------
-- local cmp = require'cmp'
-- cmp.setup({
--     -- completion = {
--     --     autocomplete = false
--     -- },
--     sources = {
--         { name = "buffer" },
--         { name = "nvim_lsp" },
--         -- { name = "luasnip" },
--         -- { name = "neorg" },
--     },
--     mapping = {
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.close(),
--         ["<cr>"] = cmp.mapping.confirm({select = true}),
--         ["<s-tab>"] = cmp.mapping.select_prev_item(),
--         ["<tab>"] = cmp.mapping.select_next_item(),
--     },
--     formatting = {
--         format = function(entry, item)
--             -- item.kind = lsp_symbols[item.kind]
--             item.abbr = string.sub(item.abbr, 1, 20)
--             item.menu = ({
--                 buffer = "[Buffer]",
--                 nvim_lsp = "[LSP]",
--                 -- luasnip = "[Snippet]",
--                 -- neorg = "[Neorg]",
--             })[entry.source.name]

--             return item
--         end,
--     },
--     -- snippet = {
--     --     expand = function(args)
--     --         luasnip.lsp_expand(args.body)
--     --     end,
--     -- },
-- })
-------------------- COMMANDS ------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

--------------------------------------------------------------------
local actions = require "fzf-lua.actions"
require'fzf-lua'.setup {
	files = {
		previewer         = false,
		cmd               = "ag --nocolor -l -g ''",
		find_opts         = "",
		git_icons         = false,
		file_icons        = false,
	},
	grep = {
		previewer         = false,
		prompt            = 'Ag❯ ',
		cmd               = "ag --nocolor",
		grep_opts         = "",
	},
	buffers = {
		previewer         = false,
	},
	tabs = {
		previewer         = false,
	},
	lines = {
		previewer         = false,
	},
}
------------------------------------------------------------
require('spaceless').setup {}
-------------------------------------------------------------
require('nvim_comment').setup({comment_empty = false})
vim.api.nvim_command [[autocmd! FileType cpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")]]
------------------------------------------------------------
--vim.cmd([[command! Ff lua require('fzf-lua').files() ]])

vim.keymap.set('n', '<Leader>f', '<cmd>lua require("fzf-lua").files()<CR>')
vim.keymap.set('n', '<Leader>b', '<cmd>lua require("fzf-lua").buffers()<CR>')
vim.keymap.set('n', '<Leader>g', '<cmd>lua require("fzf-lua").grep()<CR>')
vim.keymap.set('n', '<Leader>s', '<cmd>lua require("nvim-quick-switcher").toggle("cpp", "h")<CR>')

--vim.api.nvim_set_keymap('n', '<F2>',
--	"<cmd>lua require('fzf-lua').files()<CR>",
--	{ noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<F3>',
--	"<cmd>lua require('fzf-lua').buffers()<CR>",
--	{ noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<F4>',
--	"<cmd>lua require('fzf-lua').greep()<CR>",
--	{ noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<F4>",
--	"<cmd>:lua require('nvim-quick-switcher').toggle('cpp', 'h')<CR>",
--	{ noremap = true, silent = true })
---------------------------------------------------------
