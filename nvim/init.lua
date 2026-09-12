-----------------------------------------------------------
-- Basic Settings
-----------------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.g.mapleader = " "

vim.opt.spell = true
vim.opt.spelllang = "en"


-- Scrolling
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.smoothscroll = true

-- Don't wrap long lines
vim.opt.wrap = false

-- Mouse
vim.opt.mouse = "a"



-----------------------------------------------------------
-- vim-visual-multi
-----------------------------------------------------------

vim.g.VM_maps = {
  ["Find Under"]         = "<C-d>",
  ["Find Subword Under"] = "<C-d>",
  ["Select All"]         = "<C-S-l>",
  ["Add Cursor Down"]    = "<leader>j",
  ["Add Cursor Up"]      = "<leader>k",
  ["Skip Region"]        = "<C-x>",
  ["Remove Region"]      = "<C-p>",
  ["Undo"]               = "u",
  ["Redo"]               = "<C-r>",

  -- Tab is intentionally NOT used by CMP.
  -- Visual Multi can still use it for switching mode.
  ["Switch Mode"]        = "<Tab>",
}


-----------------------------------------------------------
-- Lazy.nvim
-----------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)



-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------

require("lazy").setup({
  -- Diagnostics
{
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  opts = {},
},
  -- Multi cursor
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
  },

  -- Mason
  {
    "williamboman/mason.nvim",
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
  },

  -- Auto HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
  },

  -- LSP
  {
    "williamboman/mason-lspconfig.nvim",
  },

  {
    "neovim/nvim-lspconfig",
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "L3MON4D3/LuaSnip",
  },

  {
    "saadparwaiz1/cmp_luasnip",
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
  },

  -- AI completion
  {
    "supermaven-inc/supermaven-nvim",

    config = function()
      require("supermaven-nvim").setup({})
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- Theme
  {
    "folke/tokyonight.nvim",
  },

})


-----------------------------------------------------------
-- Plugin Configuration
-----------------------------------------------------------

-- Mason
require("mason").setup()

-----------------------------------------------------------
-- Diagnostics / Error Lens
-----------------------------------------------------------

require("tiny-inline-diagnostic").setup({
  preset = "modern",
})

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Theme
vim.cmd.colorscheme("tokyonight")


-- Icons
require("nvim-web-devicons").setup({
  override = {},
  default = true,
})


-- File tree
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})


-- Status line
require("lualine").setup()


-- Comments
require("Comment").setup()


-- Auto pairs
require("nvim-autopairs").setup()


-- Auto HTML/JSX tags
require("nvim-ts-autotag").setup()


-----------------------------------------------------------
-- Comment Keymaps
-----------------------------------------------------------

vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, {
  desc = "Toggle comment",
})


vim.keymap.set("v", "<leader>/", function()
  local esc = vim.api.nvim_replace_termcodes(
    "<ESC>",
    true,
    false,
    true
  )

  vim.api.nvim_feedkeys(esc, "nx", false)

  require("Comment.api").toggle.linewise(
    vim.fn.visualmode()
  )
end, {
  desc = "Toggle comment",
})


-----------------------------------------------------------
-- Format
-----------------------------------------------------------

vim.keymap.set("n", "<leader>n", function()
  vim.lsp.buf.format({ async = true })
end, {
  desc = "Format file",
})


-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

-- File tree
vim.keymap.set("n", "<leader>e", function()
  local api = require("nvim-tree.api")

  if api.tree.is_visible() then
    api.tree.focus()
  else
    api.tree.open()
  end
end, {
  desc = "File Explorer",
})


-- Move to right window
vim.keymap.set("n", "<leader>l", "<C-w>l", {
  desc = "Move right",
})


-- Delete/change visual selection
vim.keymap.set("v", "<BS>", "c")


-- Telescope
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", {
  desc = "Find files",
})


-- Terminal
vim.keymap.set("n", "<leader>t", ":terminal<CR>", {
  desc = "Terminal",
})


-- Exit terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
  noremap = true,
  silent = true,
})


-----------------------------------------------------------
-- LSP
-----------------------------------------------------------

local capabilities =
  require("cmp_nvim_lsp").default_capabilities()


-- TypeScript / JavaScript
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.enable("ts_ls")


-- HTML
vim.lsp.config("html", {
  capabilities = capabilities,
})

vim.lsp.enable("html")


-- CSS
vim.lsp.config("cssls", {
  capabilities = capabilities,
})

vim.lsp.enable("cssls")


-- Emmet
vim.lsp.config("emmet_language_server", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascriptreact",
    "typescriptreact",
    "jsx",
    "tsx",
  },
})

vim.lsp.enable("emmet_language_server")


-----------------------------------------------------------
-- nvim-cmp
-----------------------------------------------------------

local cmp = require("cmp")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  mapping = {
    ["<Down>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select,
    }),

    ["<Up>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select,
    }),

    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),

    ["<C-Space>"] = cmp.mapping.complete(),
  },

  sources = {
    {
      name = "nvim_lsp",
    },
    {
      name = "luasnip",
    },
  },
})
