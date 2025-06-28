return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require('nvim-web-devicons').set_icon {
      ["cy.tsx"] = {
        icon = "",
        color = "#69D3A7",
        name = "Cypress"
      }
    }
  end
}

