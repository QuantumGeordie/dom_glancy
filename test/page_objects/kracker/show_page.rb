module PageObjects
  module Kracker
    class ShowPage < ViewerPage

      collection :not_master,  :locator => "#js--not_master",  :item_locator => 'table tbody tr'
      collection :not_current, :locator => "#js--not_current", :item_locator => 'table tbody tr'
      collection :changed,     :locator => "#js--changed",     :item_locator => 'table tbody tr'

      def bless!
        node.click_button 'Bless these differences'
        IndexPage.new
      end
    end
  end
end