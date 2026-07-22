-----------------------------------------------------------
-- Basic Settings
-----------------------------------------------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "


-----------------------------------------------------------
-- Lazy.nvim Setup
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
{
  "williamboman/mason.nvim",
},

{
  "williamboman/mason-lspconfig.nvim",
},

{
  "neovim/nvim-lspconfig",
},

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
      "nvim-tree/nvim-web-devicons"
    },
  },


  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
  },


  -- Better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },


  -- Search files
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },


  -- Theme
  {
    "folke/tokyonight.nvim",
  },


})


-----------------------------------------------------------
-- Plugin Config
-----------------------------------------------------------

require("mason").setup()
-- Theme
vim.cmd.colorscheme("tokyonight")


-- File tree
require("nvim-tree").setup()


-- Status line
require("lualine").setup()


-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------

-- Open file tree
vim.keymap.set("n", "<leader>e", function()
  local api = require("nvim-tree.api")

  if api.tree.is_visible() then
    api.tree.focus()
  else
    api.tree.open()
  end
end)
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("v", "<BS>", "c")
-- Telescope find files
vim.keymap.set(
  "n",
  "<leader>f",
  ":Telescope find_files<CR>"
)


-- Terminal
vim.keymap.set(
  "n",
  "<leader>t",
  ":terminal<CR>"
)




vim.lsp.config("ts_ls", {
  capabilities = require("cmp_nvim_lsp").default_capabilities()
})

vim.lsp.enable("ts_ls")





local cmp = require("cmp")

cmp.setup({

  mapping = cmp.mapping.preset.insert({

    ["<Tab>"] = cmp.mapping.select_next_item(),

    ["<S-Tab>"] = cmp.mapping.select_prev_item(),

    ["<CR>"] = cmp.mapping.confirm(),

  }),


  sources = {

    { name = "nvim_lsp" },

    { name = "luasnip" },

  }

})
