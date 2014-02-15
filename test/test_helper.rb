require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '.'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'minitest/unit'
require 'minitest/autorun'

require File.expand_path('../../lib/kracker', __FILE__)
test_objects_location = File.expand_path('../test_objects/*', __FILE__)
Dir[test_objects_location].each { |f| require f }

module Kracker
  class KrackerTestCase < Minitest::Unit::TestCase
    include Kracker
    include Kracker::TestObjects

  end
end