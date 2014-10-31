require 'ae_page_objects'

ActiveSupport::Dependencies.autoload_paths << 'test'

module PageObjects
  module DomGlancy
    class Site < ::AePageObjects::Site

    end
  end
end

PageObjects::DomGlancy::Site.initialize!
