require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module TestApp
  class Application < Rails::Application
    config.eager_load = true
    config.cache_classes = true
    config.serve_static_assets = true
    config.static_cache_control = "public, max-age=3600"
    config.active_support.deprecation  = :stderr

    config.encoding = 'utf-8'
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'

    # Configure cookies
    config.secret_token = (('a'..'z').to_a * 2).join
    config.session_store :cookie_store

    I18n.enforce_available_locales = false
  end
end
