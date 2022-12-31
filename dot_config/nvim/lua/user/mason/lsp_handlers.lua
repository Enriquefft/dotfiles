require("user.mason.lsp_config").setup()
local on_attach = require("user.mason.lsp_config").on_attach
local capabilities = require("user.mason.lsp_config").capabilities

local lsp_config = require("lspconfig")

return {
  function(server_name)
    lsp_config[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  ["clangd"] = function()
    -- change offset_encodings
    local clangd_capabilities = capabilities
    clangd_capabilities.offsetEncoding = { "utf-16" }
    lsp_config.clangd.setup({
      on_attach = on_attach,
      capabilities = clangd_capabilities,
    })
  end,
}
