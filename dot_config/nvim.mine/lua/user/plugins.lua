local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
		PACKER_BOOTSTRAP = fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
		}
		print "Installing packer close and reopen Neovim..."
		vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
		augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
		augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then

		vim.notify("Error with packer")
		
		return
end

--[[ Have packer use a popup window
packer.init {
		display = {
				open_fn = function()
					return require("packer.util").float { border = "rounded" }
				end,
		},
}
--]]

-------------------------

-- Install your plugins here
return packer.startup(function(use)


		use "wbthomason/packer.nvim" -- Have packer manage itself
		--use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
		--use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

		-- Comments
		use "numToStr/Comment.nvim" -- Simple commenting plugin
        --use"JoosepAlviste/nvim-ts-context-commentstring" -- TODO

		-- Autopairs
		use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
		use "windwp/nvim-ts-autotag" -- autotags for html

		-- Colorschemes
		use "ishan9299/nvim-solarized-lua" -- Solarized colorscheme for nvim

		-- cmp plugins
		use "hrsh7th/nvim-cmp" -- The completion plugin
		use "hrsh7th/cmp-buffer" -- buffer completions
		use "hrsh7th/cmp-path" -- path completions
		use "hrsh7th/cmp-cmdline" -- cmdline completions

		-- snippets
		use "L3MON4D3/LuaSnip" --snippet engine
		use "saadparwaiz1/cmp_luasnip" -- snippet completions
		use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

		-- LSP
		use "neovim/nvim-lspconfig" -- Enable LSP
		use "williamboman/nvim-lsp-installer" -- Language server installer
		use "hrsh7th/cmp-nvim-lsp" -- LSP completions with CMP

		-- Treesitter syntax highlighting
		use {
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				}
		use "p00f/nvim-ts-rainbow" -- Rainbow parentheses for neovim using tree-sitter

		-- Coq proof development
		use "whonore/Coqtail" -- plugin for vim/nvim

        -- Optimization
        use "henriquehbr/nvim-startup.lua" -- Startup timer
        use "lewis6991/impatient.nvim" -- Speed up Lua modules

        -------------------------

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if PACKER_BOOTSTRAP then
				require("packer").sync()
		end
end)
