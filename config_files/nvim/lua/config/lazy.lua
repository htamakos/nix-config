-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- this is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            -- Filer
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
                "3rd/image.nvim",
            },
            opts = {
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_hidden = false,
                    }
                },
                window = {
                    mappings = {
                        ["e"] = "open",
                        ["o"] = "open_vsplit",
                    }
                }
            },
        },
        -- Syntax Hilight
        {
            "nvim-treesitter/nvim-treesitter",
            name = 'nvim-treesitter',
            config = function()
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    auto_install = true,
                    sync_install = false,
                    highlight = { enable = true },
                    ensure_installed = 'all',
                    indent = { enable = true },
                })
            end
        },
        {
            "shellRaining/hlchunk.nvim",
            event = { "BufReadPre", "BufNewFile" },
            config = function()
                require("hlchunk").setup({
                    chunk = {
                        enable = true
                    },
                    indent = {
                        enable = true
                    }
                })
            end
        },
        { 'nanotee/sqls.nvim' },
        {
            'stevearc/conform.nvim',
            opts = {
                formatters_by_ft = {
                    sql = { "sqruff", args = { "fix", "-", "--force", "-f", "github-annotation-native" } },
                    markdown = { "mdformat" }
                },
                default_format_opts = {
                    lsp_format = "fallback",
                },
            },
        },
        -- LSP
        {
            'neovim/nvim-lspconfig',
            config = function()
                local lspconfig = require('lspconfig')
                -- Bash
                lspconfig.bashls.setup {}

                -- Java
                lspconfig.jdtls.setup {}

                -- Go
                lspconfig.gopls.setup {}

                -- Rust
                lspconfig.rust_analyzer.setup {
                    settings = {
                        ['rust-analyzer'] = {}
                    }
                }

                -- Python
                lspconfig.pyright.setup {
                    settings = {
                        python = {
                            pythonPath = '.venv/bin/python',
                        }
                    }
                }

                -- Lua
                lspconfig.lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                            },
                        },
                    },
                })

                -- Nix
                lspconfig.nil_ls.setup {}

                local is_node_dir = function()
                    return lspconfig.util.root_pattern('package.json')(vim.fn.getcwd())
                end

                -- ts_ls
                local ts_opts = {}
                ts_opts.on_attach = function(client)
                    if not is_node_dir() then
                        client.stop(true)
                    end
                end
                lspconfig.ts_ls.setup(ts_opts)

                -- denols
                local deno_opts = {}
                deno_opts.on_attach = function(client)
                    if is_node_dir() then
                        client.stop(true)
                    end
                end
                lspconfig.denols.setup(deno_opts)

                -- ruff
                lspconfig.ruff.setup {}

                -- xml
                lspconfig.lemminx.setup {}

                -- taplo
                lspconfig.taplo.setup {}

                -- biome
                lspconfig.biome.setup({
                    single_file_support = true
                })

                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                capabilities.workspace = {
                    didChangeWatchedFiles = {
                        dynamicRegistration = true,
                    },
                }
                lspconfig.markdown_oxide.setup {
                    capabilities = capabilities,
                }

                lspconfig.htmx.setup {}
                lspconfig.zk.setup {}
                lspconfig.marksman.setup {}
                lspconfig.terraformls.setup {}
                lspconfig.sqls.setup {
                    on_attach = function(client, bufnr)
                        require('sqls').on_attach(client, bufnr)
                    end
                }
            end
        },
        {
            'nvimdev/lspsaga.nvim',
            config = function()
                require('lspsaga').setup({})
            end,
            dependencies = {
                'nvim-treesitter/nvim-treesitter', -- optional
                'nvim-tree/nvim-web-devicons',     -- optional
            }
        },
        {
            "j-hui/fidget.nvim",
            opts = {
                -- options
            },
        },
        {
            'stevearc/aerial.nvim',
            opts = {},
            config = function()
                require("aerial").setup({
                    filter_kind = false,
                    autojump = true
                })
            end,
            -- Optional dependencies
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons"
            },
        },
        {
            'projekt0n/github-nvim-theme',
            name = 'github-theme',
            lazy = false,
            priority = 1000,
            config = function()
                require('github-theme').setup({
                    options = {},
                    palettes = {},
                    specs = {},
                    groups = {},
                })

                vim.cmd('colorscheme github_dark')
            end,
        },
        -- Completion
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            config = function()
                local cmp = require("cmp")
                cmp.setup({
                    sources = cmp.config.sources({
                        {
                            name = "nvim_lsp",
                            option = {
                                markdown_oxide = {
                                    keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
                                },
                            },
                        },
                        { name = "cmdline" },
                        { name = "buffer" },
                        { name = "path" },
                    }),
                    mapping = {
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    },
                })
            end
        },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        -- Fuzzy Finder
        {
            "nvim-telescope/telescope.nvim",
            dependencies = "tsakirist/telescope-lazy.nvim",
            config = function()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
                vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
            end
        },
        -- window
        {
            'simeji/winresizer',
            name = 'winresizer',
            config = function()
                vim.g.winresizer_vert_resize = 1
                vim.g.winresizer_horiz_resize = 1
            end
        },
        {
            'kassio/neoterm',
            config = function()
                vim.g.neoterm_autoinsert = 1
                vim.g.neoterm_autoscroll = 1
                vim.g.neoterm_default_mod = "belowright"
                vim.g.neoterm_size = 10
            end
        },
        -- others
        {
            'windwp/nvim-autopairs',
            event = "InsertEnter",
            config = true
        },
        {
            'folke/which-key.nvim',
            event = "VeryLazy",
            opts = {},
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            opts = {},
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            }
        },
        -- markdown
        {
            'ixru/nvim-markdown',
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
            opts = {},
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && yarn install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        {
            '3rd/image.nvim',
            config = function()
                require("image").setup({
                    backend = "kitty",
                })
            end
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            options = { theme = 'gruvbox' },
            config = function()
                require('lualine').setup({})
            end
        },
        {
            'romgrk/barbar.nvim',
            dependencies = {
                'lewis6991/gitsigns.nvim',
                'nvim-tree/nvim-web-devicons',
            },
            init = function() vim.g.barbar_auto_setup = false end,
            opts = {
            },
            version = '^1.0.0', -- optional: only update when a new 1.x version is released
        },
        -- Git
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup {
                    on_attach = function(bufnr)
                        local gitsigns = require('gitsigns')

                        local function map(mode, l, r, opts)
                            opts = opts or {}
                            opts.buffer = bufnr
                            vim.keymap.set(mode, l, r, opts)
                        end

                        -- Navigation
                        map('n', ']c', function()
                            if vim.wo.diff then
                                vim.cmd.normal({ ']c', bang = true })
                            else
                                gitsigns.nav_hunk('next')
                            end
                        end)

                        map('n', '[c', function()
                            if vim.wo.diff then
                                vim.cmd.normal({ '[c', bang = true })
                            else
                                gitsigns.nav_hunk('prev')
                            end
                        end)

                        -- Actions
                        map('n', '<leader>hs', gitsigns.stage_hunk)
                        map('n', '<leader>hr', gitsigns.reset_hunk)

                        map('v', '<leader>hs', function()
                            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                        end)

                        map('v', '<leader>hr', function()
                            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                        end)

                        map('n', '<leader>hS', gitsigns.stage_buffer)
                        map('n', '<leader>hR', gitsigns.reset_buffer)
                        map('n', '<leader>hp', gitsigns.preview_hunk)
                        map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                        map('n', '<leader>hb', function()
                            gitsigns.blame_line({ full = true })
                        end)

                        map('n', '<leader>hd', gitsigns.diffthis)

                        map('n', '<leader>hD', function()
                            gitsigns.diffthis('~')
                        end)

                        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                        map('n', '<leader>hq', gitsigns.setqflist)

                        -- Toggles
                        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                        map('n', '<leader>td', gitsigns.toggle_deleted)
                        map('n', '<leader>tw', gitsigns.toggle_word_diff)

                        -- Text object
                        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                    end
                }
            end
        }
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

vim.keymap.set('n', '<Leader>e', ':Neotree filesystem toggle left<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>c', ':Lspsaga code_action<CR>', { noremap = true })
vim.keymap.set('n', 'e[', '<cmd>Lspsaga diagnostics_jump_prev<CR>', { noremap = true })
vim.keymap.set('n', ']e', '<cmd>Lspsaga diagnostics_jump_next<CR>', { noremap = true })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { noremap = true })
vim.keymap.set('n', '<Leader>gd', ':Lspsaga goto_definition<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>gt', ':Lspsaga goto_type_definition<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>a', ':AerialToggle right<CR>', { noremap = true })

vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format({ lsp_format = "fallback", range = range })
end, { range = true })
