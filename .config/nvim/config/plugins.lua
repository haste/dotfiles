local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"
  print(pckr_path)

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/lewis6991/pckr.nvim",
      pckr_path,
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require("pckr").add({
  --
  -- Colorschemes
  --

  -- https://github.com/dracula/vim
  -- :scream: A dark theme for Vim
  "dracula/vim",

  --
  -- General
  --

  -- https://github.com/stevearc/conform.nvim
  -- Lightweight yet powerful formatter plugin for Neovim
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")

      local slow_format_filetypes = {}

      local javascript = { "biome", "prettier" }

      conform.setup({
        formatters_by_ft = {
          css = javascript,
          elixir = { "mix" },
          heex = { "mix" },
          html = { "djlint" },
          javascript = javascript,
          javascriptreact = javascript,
          json = javascript,
          lua = { "stylua" },
          python = { "black" },
          scss = javascript,
          sql = { "sleek" },
          typescript = javascript,
          typescriptreact = javascript,
          vue = { "prettier" },
        },
        format_on_save = function(bufnr)
          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 200, lsp_format = "fallback" }, on_format
        end,

        format_after_save = function(bufnr)
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return { lsp_format = "fallback" }
        end,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          conform.format({ bufnr = args.buf })
        end,
      })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter
  --  Nvim Treesitter configurations and abstraction layer
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {
          "c",
          "cpp",
          "css",
          "elixir",
          "fish",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "php",
          "python",
          "query",
          "sql",
          "terraform",
          "typescript",
          "vim",
          "vimdoc",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },

  -- https://github.com/bitc/vim-bad-whitespace
  -- Highlights whitespace at the end of lines, only in modifiable buffers
  "bitc/vim-bad-whitespace",

  -- https://github.com/godlygeek/tabular
  -- Vim script for text filtering and alignment
  "godlygeek/tabular",

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- https://github.com/sschleemilch/slimline.nvim
  --  A minimal neovim statusline
  {
    "sschleemilch/slimline.nvim",
    requires = { "lewis6991/gitsigns.nvim" },
    config = function()
      require("slimline").setup({
        style = "bg",
        configs = {
          path = {
            hl = {
              primary = "Define",
            },
          },
          git = {
            hl = {
              primary = "Function",
            },
          },
          diagnostics = {
            hl = {
              primary = "Statement",
            },
          },
          filetype_lsp = {
            hl = {
              primary = "String",
            },
          },
          progress = {
            column = true, -- Enables a secondary section with the cursor column
          },
        },
        spaces = {
          components = "─",
          left = "─",
          right = "─",
        },
      })

      vim.opt.fillchars = {
        horiz = "─",
        horizdown = "┬",
        horizup = "┴",
        stl = "─",
        vert = "│",
        verthoriz = "┼",
        vertleft = "┤",
        vertright = "├",
      }
    end,
  },

  -- https://github.com/ibhagwan/fzf-lua
  -- Improved fzf.vim written in lua
  {
    "ibhagwan/fzf-lua",
    config = function()
      local fzf = require("fzf-lua")

      vim.keymap.set("n", "<Leader><Leader>", fzf.files, { noremap = true, silent = true })
      vim.keymap.set("n", "<Leader><Enter>", fzf.buffers, { noremap = true, silent = true })

      fzf.setup({
        fzf_opts = {
          ["--inline-info"] = true,
        },
        winopts = {
          fullscreen = true,
        },
      })
    end,
  },

  -- https://github.com/tpope/vim-abolish
  -- easily search for, substitute, and abbreviate multiple variants of a word
  "tpope/vim-abolish",

  -- https://github.com/simnalamburt/vim-mundo
  -- Vim undo tree visualizer
  "simnalamburt/vim-mundo",

  -- https://github.com/mbbill/undotree
  --  The undo history visualizer for VIM
  "mbbill/undotree",

  -- https://github.com/ap/vim-css-color
  -- Preview colours in source code while editing
  "ap/vim-css-color",

  -- https://github.com/neovim/nvim-lspconfig
  --  Quickstart configs for Nvim LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Elixir
      vim.lsp.config("expert", {
        cmd = { "expert" },
        root_markers = { "mix.exs", ".git" },
        filetypes = { "elixir", "eelixir", "heex" },
      })

      vim.lsp.enable("expert")

      -- Python
      vim.lsp.enable("pyright")
    end,
  },

  -- https://github.com/mfussenegger/nvim-lint
  --  An asynchronous linter plugin for Neovim complementary to the built-in
  --  Language Server Protocol support.
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        elixir = { "credo" },
        fish = { "fish" },
        javascript = { "biomejs", "eslint" },
        python = { "ruff", "flake8" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          pcall(lint.try_lint)
        end,
      })
    end,
  },

  -- https://github.com/poljar/typos.nvim
  --  Using typos-cli to show diagnostics warnings in nvim
  {
    "poljar/typos.nvim",
    config = function()
      require("typos").setup()
    end,
  },

  ---
  --- Completion
  ---

  -- https://github.com/neoclide/coc.nvim
  --  Nodejs extension host for vim & neovim, load extensions like VSCode and host
  --  language servers.
  { "neoclide/coc.nvim", branch = "release" },
})
