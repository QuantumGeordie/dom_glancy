ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rails/all'
require 'kracker'
require 'test_app/test_app'

require 'minitest/autorun'

require 'awesome_print'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'

test_objects_location = File.expand_path('../test_objects/*', __FILE__)
Dir[test_objects_location].each { |f| require f }

test_helper_location = File.expand_path('../test_helpers/**/*.rb', __FILE__)
Dir[test_helper_location].each { |f| require f }

Capybara.default_driver = :selenium

module Kracker
  class SeleniumTestCase < Minitest::Test
    include Kracker
    include Kracker::TestObjects
    include Kracker::TestHelpers::Location

    include Capybara::DSL

  end
end