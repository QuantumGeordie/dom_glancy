db_name = "kracker_#{Rails.env}"

`mysql -uroot -e "DROP DATABASE IF EXISTS #{db_name}; CREATE DATABASE IF NOT EXISTS #{db_name};"`

log_file = File.expand_path(File.join(__FILE__, '..', 'log', '*'))
`rm -rf #{log_file}`

module KrackerApp
  class Application < Rails::Application
    config.root = File.expand_path(File.join(__FILE__, '..', '..', 'test_app'))
    config.eager_load = true
    config.cache_classes = true
    config.active_support.deprecation  = :stderr

    # Enable the asset pipeline
    config.assets.enabled = true

    # Configure static asset server for tests with Cache-Control for performance
    config.serve_static_assets = true
    config.static_cache_control = "public, max-age=3600"

    # Configure cookies
    config.secret_token = (('a'..'z').to_a * 2).join
    config.session_store :cookie_store

    I18n.enforce_available_locales = false
  end
end

KrackerApp::Application.initialize!
