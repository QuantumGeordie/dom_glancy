module PageObjects
  module DomGlancy
    class IndexPage < ViewerPage
      path :dom_glancy

      collection :files, :locator => '#kr--files', :item_locator => '.kr--file'
    end
  end
end
