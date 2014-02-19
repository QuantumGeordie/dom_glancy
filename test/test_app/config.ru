# This file is used by Rack-based servers to start the application.
ENV['RAILS_ENV'] = 'development'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'bundler'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require "action_controller/railtie"
require "sprockets/railtie"
require 'rails'

require 'kracker'

Rails.backtrace_cleaner.remove_silencers!

require 'test_app'
run KrackerApp::Application
