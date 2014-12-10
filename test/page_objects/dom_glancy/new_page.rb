module PageObjects
  module DomGlancy
    class NewFile < AePageObjects::Element
      element :name, :locator => 'td:nth-child(1)'
      def make_master
        node.click_link_or_button('make master')
        window.change_to(NewPage)
      end
      def delete
        node.click_link_or_button('delete')
        window.change_to(NewPage)
      end
    end

    class NewPage < ViewerPage
      path '/dom_glancy/new'

      collection :files, :locator => '#js--files', :item_locator => '.js--new_files', :contains => NewFile
    end
  end
end
