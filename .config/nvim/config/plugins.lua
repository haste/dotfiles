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

      local never_format_filetypes = {
        razor = true, -- Roslyn corrupts razor files on format
      }

      local javascript = { "biome", "prettier" }

      conform.setup({
        formatters_by_ft = {
          css = javascript,
          elixir = { "mix" },
          go = { "goimports" },
          heex = { "mix" },
          htmldjango = { "djlint" },
          html = { "djlint" },
          javascript = javascript,
          javascriptreact = javascript,
          json = javascript,
          lua = { "stylua" },
          php = { "mago_format" },
          python = { "black" },
          scss = javascript,
          sql = { "sleek" },
          typescript = javascript,
          typescriptreact = javascript,
          vue = { "prettier" },
        },
        format_on_save = function(bufnr)
          if never_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return { timeout_ms = 200, lsp_format = "fallback" }
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
    -- main branch = the 0.12 rewrite; repo is archived, so pin to its final commit.
    branch = "main",
    commit = "4916d6592ede8c07973490d9322f187e07dfefac",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "c",
        "c_sharp",
        "cpp",
        "css",
        "diff",
        "editorconfig",
        "elixir",
        "fish",
        "gitcommit",
        "gitignore",
        "git_config",
        "git_rebase",
        "go",
        "html",
        "javascript",
        "json",
        "jsx",
        "lua",
        "php",
        "python",
        "query",
        "razor",
        "sql",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end

          local ok, added = pcall(vim.treesitter.language.add, lang)
          if ok and added then
            vim.treesitter.start(args.buf, lang)
            -- Use filetype indent if tree-sitter doesn't have it
            if vim.treesitter.query.get(lang, "indents") then
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end,
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

      -- Go
      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
      })

      vim.lsp.enable("gopls")

      -- TypeScript
      vim.lsp.config("tsserver", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = { "package.json", "tsconfig.json", ".git" },
      })

      vim.lsp.enable("tsserver")

      vim.lsp.enable("html")

      -- 0.12 provides grn/gra/grr/gri/gO/K by default; add go-to-definition.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        end,
      })
    end,
  },

  -- https://github.com/seblyng/roslyn.nvim
  --  Roslyn (Microsoft.CodeAnalysis.LanguageServer) support for C#.
  {
    "seblyng/roslyn.nvim",
    config = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })

      require("roslyn").setup({})

      vim.lsp.config("roslyn", {
        filetypes = { "cs", "razor" },
      })
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

  -- https://github.com/folke/trouble.nvim
  --  A pretty, navigable list of diagnostics shown in a bottom split.
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        modes = {
          diagnostics = {
            win = { position = "bottom", size = 10 },
          },
        },
      })

      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
      vim.keymap.set(
        "n",
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        { desc = "Buffer diagnostics (Trouble)" }
      )
    end,
  },

  ---
  --- Completion
  ---

  -- https://github.com/saghen/blink.cmp
  --  Performant, batteries-included completion; auto popup while typing.
  {
    "saghen/blink.cmp",
    tag = "v1.*",
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = "default" },
        sources = { default = { "lsp", "path", "buffer" } },

        appearance = {
          -- Nerd Font is installed; use the mono variant so icon columns align.
          nerd_font_variant = "mono",
        },

        completion = {
          menu = {
            border = "rounded",
            draw = {
              -- Highlight completion labels with treesitter for language-aware colors.
              treesitter = { "lsp" },
              -- icon | label + inline type | kind name
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = { border = "rounded" },
          },
          -- Subtle ghost-text preview of the selected item inline.
          ghost_text = { enabled = true },
        },

        signature = {
          enabled = true,
          window = { border = "rounded" },
        },
      })

      -- Advertise blink's capabilities to every LSP server.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
    end,
  },
})
