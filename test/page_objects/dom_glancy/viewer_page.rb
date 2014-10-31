module PageObjects
  module DomGlancy
    class ViewerPage < ::AePageObjects::Document
      element :navigation, :is => Navigation, :locator => "#js-kr--nav"

      def revision
        node.find("#js-kr--gem_rev").text
      end

    end
  end
end



