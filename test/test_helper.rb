require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

ENV['RAILS_ENV'] = 'test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'awesome_print'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'mocha/setup'

require File.expand_path('../../lib/kracker', __FILE__)

test_objects_location = File.expand_path('../test_objects/*', __FILE__)
Dir[test_objects_location].each { |f| require f }

test_helper_location = File.expand_path('../test_helpers/**/*.rb', __FILE__)
Dir[test_helper_location].each { |f| require f }

module Kracker
  class KrackerTestCase < Minitest::Test
    include Kracker
    include Kracker::TestObjects
    include Kracker::TestHelpers::Location

  end
end