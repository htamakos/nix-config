require("config.lazy")

-- Options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.list = true
vim.opt.listchars = "tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%"
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.visualbell = true
vim.opt.showmatch = true
vim.opt.laststatus = 2
vim.opt.wildmode = "list:longest"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.foldmethod = "syntax"
vim.opt.clipboard = "unnamedplus"

-- Key Maps
local remap_default_opts = { noremap = true, silent = true }

-- Map Leader
vim.keymap.set("", "<Space>", "<Nop>", remap_default_opts)

-- Custom Key Mappings
vim.keymap.set('n', 'd', '"_d', remap_default_opts)
vim.keymap.set('x', 'd', '"_d', remap_default_opts)
vim.keymap.set('v', 'd', '"_d', remap_default_opts)
vim.keymap.set('n', 'x', '"_x', remap_default_opts)
vim.keymap.set('x', 'x', '"_x', remap_default_opts)
vim.keymap.set('v', 'x', '"_x', remap_default_opts)
vim.keymap.set('n', ':', ';', remap_default_opts)
vim.keymap.set('n', ';', ':', remap_default_opts)
vim.keymap.set('i', 'jj', '<ESC>', remap_default_opts)
vim.keymap.set('n', '<Leader>o', ':CtrlP<CR>')
vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('v', '<Leader>d', '"+d')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('n', '<Leader>P', '"+P')
vim.keymap.set('v', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>P', '"+P')
vim.keymap.set('n', '<Leader><Leader>', 'V')
vim.keymap.set('n', 's', '<Nop', remap_default_opts)
vim.keymap.set('n', 'sj', '<C-w>j', remap_default_opts)
vim.keymap.set('n', 'sk', '<C-w>k', remap_default_opts)
vim.keymap.set('n', 'sl', '<C-w>l', remap_default_opts)
vim.keymap.set('n', 'sh', '<C-w>h', remap_default_opts)
vim.keymap.set('n', 'sJ', '<C-w>J', remap_default_opts)
vim.keymap.set('n', 'sK', '<C-w>K', remap_default_opts)
vim.keymap.set('n', 'sL', '<C-w>L', remap_default_opts)
vim.keymap.set('n', 'sH', '<C-w>H', remap_default_opts)
vim.keymap.set('n', 'sn', 'gt', remap_default_opts)
vim.keymap.set('n', 'sp', 'gT', remap_default_opts)
vim.keymap.set('n', 'sr', '<C-w>r', remap_default_opts)
vim.keymap.set('n', 's=', '<C-w>=', remap_default_opts)
vim.keymap.set('n', 'sw', '<C-w>w', remap_default_opts)
vim.keymap.set('n', 'so', '<C-w>_<C-w>|', remap_default_opts)
vim.keymap.set('n', 'sO', '<C-w>=', remap_default_opts)
vim.keymap.set('n', 'sN', ':<C-u>bn<CR>', remap_default_opts)
vim.keymap.set('n', 'sP', ':<C-u>bp<CR>', remap_default_opts)
vim.keymap.set('n', 'st', ':<C-u>tabnew<CR>', remap_default_opts)
vim.keymap.set('n', 'ss', ':<C-u>sp<CR>', remap_default_opts)
vim.keymap.set('n', 'vs', ':<C-u>vs<CR>', remap_default_opts)
vim.keymap.set('n', 'sq', ':<C-u>q<CR>', remap_default_opts)
vim.keymap.set('n', 'sQ', ':<C-u>bd<CR>', remap_default_opts)

vim.keymap.set('n', 'ff', ':lua vim.lsp.buf.format()<CR>', remap_default_opts)

-- For Terminal Mode
vim.keymap.set('t', '<ESC>', "<C-\\><C-n>", remap_default_opts)
vim.keymap.set('t', 'jj', "<C-\\><C-n>", remap_default_opts)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.indentexpr = ""
    end,
})
--autocmd VimEnter * :Tnew
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("Tnew")
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        vim.cmd("Neotree filesystem toggle left")
    end
})
