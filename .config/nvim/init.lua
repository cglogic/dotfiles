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

	'neovim/nvim-lspconfig';
	'hrsh7th/cmp-nvim-lsp';
	-- 'hrsh7th/cmp-buffer';
	'L3MON4D3/LuaSnip';
	'hrsh7th/nvim-cmp';

	'ibhagwan/fzf-lua';
	-- 'lewis6991/spaceless.nvim';
	-- 'terrortylor/nvim-comment';
	-- 'Everduin94/nvim-quick-switcher';
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
		section_separators = '',
		component_separators = '',
	}
}

-------------------- TREE-SITTER ---------------------------
require('nvim-treesitter.configs').setup {
	-- ensure_installed = 'maintained',
	ensure_installed = { "c", "cpp", "python", "json", "lua", "markdown", "ninja", "regex", "vim" },
	highlight = {
		enable = true
	}
}

-------------------- LSP -----------------------------------
-- local lsp = require 'lspconfig'

-- Setup lspconfig.
local lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['ccls'].setup {
	init_options = {
		cache = {
			directory = os.getenv('XDG_RUNTIME_DIR') .. '/ccls-cache';
		};
	},
	autostart = true,
	capabilities = lsp_capabilities,
}

-- require('lspconfig')['clangd'].setup {
-- 	autostart = true,
-- 	cmd = {
-- 		"clangd14",
-- 		"--background-index",
-- 		"--suggest-missing-includes",
-- 	},
-- 	capabilities = lsp_capabilities,
-- }

map('n', '<space>,', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.diagnostic.goto_next()<CR>')
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
		border = 'rounded',
		focusable = false,
	},
}

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
	local opts = _default_opts(options)
	opts.border = 'rounded'
	return opts
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
	vim.lsp.handlers.hover,
	{border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
	vim.lsp.handlers.signature_help,
	{border = 'rounded'}
)

------------------------------------------------------------
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local luasnip = require('luasnip')
local cmp = require('cmp')
cmp.setup({
	window = {
		documentation = {
			border = 'rounded',
		},
		completion = {
			border = 'rounded',
		},
	},
	completion = {
		autocomplete = false
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	-- }, {
		-- { name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

		['<C-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { 'i', 's' }),

		['<C-S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	formatting = {
		format = function(entry, item)
			-- item.kind = lsp_symbols[item.kind]
			item.abbr = string.sub(item.abbr, 1, 50)
			item.menu = ({
				-- buffer = '[Buffer]',
				nvim_lsp = '[LSP]',
				luasnip = '[Snippet]',
			})[entry.source.name]

			return item
		end,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
})

-------------------- COMMANDS ------------------------------
cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

--------------------------------------------------------------------
local actions = require 'fzf-lua.actions'
require('fzf-lua').setup {
	files = {
		previewer         = false,
		cmd               = 'ag --nocolor -l -g ""',
		find_opts         = '',
		git_icons         = false,
		file_icons        = false,
	},
	grep = {
		previewer         = false,
		prompt            = 'Ag❯ ',
		cmd               = 'ag --nocolor',
		grep_opts         = '',
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
-- require('spaceless').setup {}

-------------------------------------------------------------
-- require('nvim_comment').setup({comment_empty = false})
-- vim.api.nvim_command [[autocmd! FileType cpp :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")]]

------------------------------------------------------------
vim.keymap.set('n', '<Leader>f', '<cmd>lua require("fzf-lua").files()<CR>')
vim.keymap.set('n', '<Leader>b', '<cmd>lua require("fzf-lua").buffers()<CR>')
vim.keymap.set('n', '<Leader>g', '<cmd>lua require("fzf-lua").grep()<CR>')
-- vim.keymap.set('n', '<Leader>s', '<cmd>lua require("nvim-quick-switcher").toggle("cpp", "h")<CR>')
