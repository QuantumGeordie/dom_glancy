module PageObjects
  module DomGlancy
    class ViewerPage < ::AePageObjects::Document
      element :navigation, :is => Navigation, :locator => "#js-dg--nav"

      def revision
        node.find("#js-dg--gem_rev").text
      end

    end
  end
end



