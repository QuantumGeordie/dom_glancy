require 'ae_page_objects'

ActiveSupport::Dependencies.autoload_paths << 'test'

module PageObjects
  module Kracker
    class Site < ::AePageObjects::Site

    end
  end
end

PageObjects::Kracker::Site.initialize!