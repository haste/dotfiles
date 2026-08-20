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

--
-- Python tooling: project uv env, then a global install, then `uv tool run`
--

-- Tools uv may fetch on demand, mapped to their package
local python_packages = { black = "black", ruff = "ruff", ["pyright-langserver"] = "pyright" }

-- Argv for a tool, or nil when nothing provides it
local function python_command(tool, path)
  local root = vim.fs.root((path and path ~= "") and path or vim.fn.getcwd(), ".venv")
  local bin = root and root .. "/.venv/bin/" .. tool

  if bin and vim.fn.executable(bin) == 1 then
    return { bin }
  end

  -- Also covers an activated venv, which puts its bin on $PATH
  if vim.fn.executable(tool) == 1 then
    return { tool }
  end

  local package = python_packages[tool]
  if package and vim.fn.executable("uv") == 1 then
    return { "uv", "tool", "run", "--from", package, tool }
  end
end

-- Ruff formats where the project configures it, unless black is configured too
local function python_ft_formatters(bufnr)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local dir = path ~= "" and path or vim.fn.getcwd()

  if vim.fs.root(dir, { "ruff.toml", ".ruff.toml" }) then
    return { "ruff_format" }
  end

  local root = vim.fs.root(dir, "pyproject.toml")
  if root then
    local ruff = false
    for line in io.lines(root .. "/pyproject.toml") do
      if line:match("^%s*%[tool%.black") then
        return { "black" }
      elseif line:match("^%s*%[tool%.ruff") then
        ruff = true
      end
    end
    if ruff then
      return { "ruff_format" }
    end
  end

  return { "black" }
end

-- Bare name as fallback so conform reports it missing
local function python_formatter(tool)
  return function(bufnr)
    local argv = python_command(tool, vim.api.nvim_buf_get_name(bufnr)) or { tool }
    local command = table.remove(argv, 1)
    return { command = command, prepend_args = argv }
  end
end

-- Resolved at lint time; args length varies by source
local function python_linter(tool)
  return function()
    local base = require("lint.linters." .. tool)
    local argv = python_command(tool, vim.api.nvim_buf_get_name(0)) or { tool }
    local cmd = table.remove(argv, 1)

    return vim.tbl_extend("force", base, {
      cmd = cmd,
      args = vim.list_extend(argv, base.args or {}),
    })
  end
end

-- Whether a root's TypeScript serves LSP natively (7+); no pinned typescript means the global tsc
local function typescript_is_native(root)
  local file = root and io.open(root .. "/node_modules/typescript/package.json")
  if not file then
    return true
  end

  local ok, pkg = pcall(vim.json.decode, file:read("a"))
  file:close()

  local major = ok and type(pkg) == "table" and tonumber(tostring(pkg.version):match("^%d+"))
  return not major or major >= 7
end

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

      -- Opt-in via .csharpierrc or .editorconfig max_line_length
      local function csharpier_opted_in(filename)
        for dir in vim.fs.parents(filename) do
          for _, name in ipairs({ ".csharpierrc", ".csharpierrc.json", ".csharpierrc.yaml", ".csharpierrc.yml" }) do
            if vim.uv.fs_stat(dir .. "/" .. name) then
              return true
            end
          end
          local editorconfig = dir .. "/.editorconfig"
          if vim.uv.fs_stat(editorconfig) then
            for line in io.lines(editorconfig) do
              if line:match("^%s*max_line_length%s*=") then
                return true
              end
            end
          end
        end
        return false
      end

      local javascript = { "biome", "prettier" }

      conform.setup({
        formatters_by_ft = {
          cs = { "csharpier" },
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
          python = python_ft_formatters,
          scss = javascript,
          sql = { "sleek" },
          typescript = javascript,
          typescriptreact = javascript,
          vue = { "prettier" },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          -- Razor formats asynchronously via a BufWritePost autocmd below
          if vim.bo[bufnr].filetype == "razor" then
            return
          end

          -- CSharpier and python tools exceed 200ms on cold start
          local ft = vim.bo[bufnr].filetype
          local timeout = (ft == "cs" or ft == "python") and 2000 or 200
          return { timeout_ms = timeout, lsp_format = "fallback" }
        end,
      })

      -- Full-document formatting mangles razor markup; only format @code/@{} blocks
      local function razor_code_blocks(bufnr)
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "razor")
        if not ok or not parser then
          return {}
        end
        local blocks = {}
        for node in parser:parse()[1]:root():iter_children() do
          if node:type() == "razor_block" then
            local open_row, close_row
            for child in node:iter_children() do
              if child:type() == "{" and not open_row then
                open_row = child:range()
              elseif child:type() == "}" then
                close_row = child:range()
              end
            end
            local sr, sc, er, ec = node:range()
            if open_row and close_row and close_row > open_row + 1 then
              -- Prepend so blocks format bottom-up, keeping earlier positions valid
              table.insert(blocks, 1, {
                first = open_row + 1, -- 0-indexed first body line
                last = close_row, -- 0-indexed, exclusive
                lsp_range = { start = { sr + 1, sc }, ["end"] = { er + 1, ec } },
              })
            end
          end
        end
        return blocks
      end

      local function csharpier_format_block(buf, block, done)
        local body = vim.api.nvim_buf_get_lines(buf, block.first, block.last, false)
        local input = "class __Razor__\n{\n" .. table.concat(body, "\n") .. "\n}\n"
        local tick = vim.b[buf].changedtick
        vim.system(
          { "csharpier", "format", "--write-stdout" },
          { stdin = input, cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(buf)), text = true },
          vim.schedule_wrap(function(res)
            if not vim.api.nvim_buf_is_valid(buf) or vim.b[buf].changedtick ~= tick then
              return done()
            end
            if res.code ~= 0 then
              local err = res.stderr ~= "" and res.stderr or res.stdout
              vim.notify("csharpier (razor @code): " .. vim.trim(err or ""), vim.log.levels.WARN)
              return done()
            end
            local out = vim.split(res.stdout, "\n")
            -- Strip the dummy class wrapper and trailing blank lines
            table.remove(out, 1)
            table.remove(out, 1)
            while out[#out] == "" do
              table.remove(out)
            end
            if out[#out] == "}" then
              table.remove(out)
            end
            local changed = #out ~= #body
            if not changed then
              for i = 1, #out do
                if out[i] ~= body[i] then
                  changed = true
                  break
                end
              end
            end
            if changed then
              vim.api.nvim_buf_set_lines(buf, block.first, block.last, false, out)
            end
            done()
          end)
        )
      end

      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.razor", "*.cshtml" },
        callback = function(args)
          local buf = args.buf
          if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
            return
          end

          -- Skip the write we trigger ourselves after formatting
          if vim.b[buf].razor_formatting then
            vim.b[buf].razor_formatting = false
            return
          end

          local blocks = razor_code_blocks(buf)
          local use_csharpier = vim.fn.executable("csharpier") == 1
            and csharpier_opted_in(vim.api.nvim_buf_get_name(buf))

          local function format_next(index)
            local block = blocks[index]
            if not block then
              if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
                vim.b[buf].razor_formatting = true
                vim.api.nvim_buf_call(buf, function()
                  vim.cmd("silent update")
                end)
              end
              return
            end
            if use_csharpier then
              csharpier_format_block(buf, block, function()
                format_next(index + 1)
              end)
            else
              conform.format({ bufnr = buf, async = true, lsp_format = "fallback", range = block.lsp_range }, function()
                format_next(index + 1)
              end)
            end
          end
          format_next(1)
        end,
      })

      conform.formatters.csharpier = {
        condition = function(_, ctx)
          return csharpier_opted_in(ctx.filename)
        end,
      }

      conform.formatters.black = python_formatter("black")
      conform.formatters.ruff_format = python_formatter("ruff")

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
        "bash",
        "c",
        "c_sharp",
        "comment",
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
        "heex",
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
        "typst",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
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
      vim.lsp.config("pyright", {
        -- Resolved per client so each root gets its own env
        cmd = function(dispatchers, config)
          local argv = python_command("pyright-langserver", config.root_dir) or { "pyright-langserver" }
          table.insert(argv, "--stdio")
          return vim.lsp.rpc.start(argv, dispatchers)
        end,
        -- Otherwise pyright can't resolve project dependencies
        on_init = function(client)
          local python = python_command("python", client.root_dir)
          if python then
            client.settings =
              vim.tbl_deep_extend("force", client.settings or {}, { python = { pythonPath = python[1] } })
          end
        end,
      })

      if python_command("pyright-langserver") then
        vim.lsp.enable("pyright")
      end

      -- Go
      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
      })

      vim.lsp.enable("gopls")

      local function typescript_root_dir(server, native)
        local base = vim.lsp.config[server].root_dir
        return function(bufnr, on_dir)
          base(bufnr, function(dir)
            if typescript_is_native(dir) == native then
              on_dir(dir)
            end
          end)
        end
      end

      vim.lsp.config("tsgo", {
        -- TS 7 renamed the tsgo binary to tsc; prefer the project's own
        cmd = function(dispatchers, config)
          local tsc = ((config or {}).root_dir or "") .. "/node_modules/.bin/tsc"
          if vim.fn.executable(tsc) ~= 1 then
            tsc = "tsc"
          end
          return vim.lsp.rpc.start({ tsc, "--lsp", "--stdio" }, dispatchers)
        end,
        root_dir = typescript_root_dir("tsgo", true),
      })

      vim.lsp.config("ts_ls", {
        root_dir = typescript_root_dir("ts_ls", false),
      })

      vim.lsp.enable({ "tsgo", "ts_ls" })

      -- Handles razor markup formatting; the default 120-char wrap corrupts @code blocks
      vim.lsp.config("html", {
        settings = {
          html = {
            format = {
              wrapLineLength = 0,
              wrapAttributes = "force-expand-multiline",
            },
          },
        },
      })

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

      for _, tool in ipairs(lint.linters_by_ft.python) do
        lint.linters[tool] = python_linter(tool)
      end

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          pcall(lint.try_lint, nil, {
            -- Skip linters that aren't installed
            filter = function(linter)
              local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
              return cmd ~= nil and vim.fn.executable(cmd) == 1
            end,
          })
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
