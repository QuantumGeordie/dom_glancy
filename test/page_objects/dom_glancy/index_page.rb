module PageObjects
  module DomGlancy
    class IndexPage < ViewerPage
      path :dom_glancy

      collection :files, :locator => '#dg--files', :item_locator => '.dg--file'
    end
  end
end
