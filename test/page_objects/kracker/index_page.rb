module PageObjects
  module Kracker
    class IndexPage < ViewerPage
      path :kracker

      collection :files, :locator => '#kr--files', :item_locator => '.kr--file'
    end
  end
end