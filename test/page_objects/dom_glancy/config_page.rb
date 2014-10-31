module PageObjects
  module DomGlancy
    class ConfigPage < ViewerPage
      path '/dom_glancy/config'

      def master
        node.find("#js-config_master").text
      end

      def current
        node.find("#js-config_current").text
      end

      def diffs
        node.find("#js-config_diffs").text
      end
    end
  end
end
