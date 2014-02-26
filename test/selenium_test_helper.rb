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

require 'page_objects'

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

    def setup
      delete_contents_from_kracker_locations
    end

    def teardown
      delete_contents_from_kracker_locations
    end

    def visit_index
      PageObjects::Kracker::IndexPage.visit
    end

    def remove_about_element
      js = <<-JS
        var element = document.getElementById('js-kr--nav');
        element.parentNode.removeChild(element);
      JS

      page.driver.browser.execute_script(js)
    end

    def add_centered_element(text_content)
      js = <<-JS
            var centeredElement = document.createElement('div');
            centeredElement.style.textAlign = 'center';
            centeredElement.style.fontSize = '2em';
            centeredElement.style.width = '400px';
            centeredElement.style.marginLeft = 'auto';
            centeredElement.style.marginRight = 'auto';
            centeredElement.id = 'hack-element';
            centeredElement.textContent = '#{text_content}';
            centeredElement.style.backgroundColor = '#ff0000'
            document.getElementsByTagName('body')[0].appendChild(centeredElement);
      JS

      page.driver.browser.execute_script(js)
    end

    def assert_artifacts_on_difference(test_root)
      filename = Kracker.diff_filename(test_root)
      assert File.exists?(filename), "Diff file should exist: #{filename}"

      filename = File.join(Kracker.diff_file_location, "#{test_root}__changed_master__diff.yaml")
      assert File.exists?(filename), "Changed master file should exist: #{filename}"

      filename = File.join(Kracker.diff_file_location, "#{test_root}__current_not_master__diff.yaml")
      assert File.exists?(filename), "Current, not master, file should exist: #{filename}"

      filename = File.join(Kracker.diff_file_location, "#{test_root}__master_not_current__diff.yaml")
      assert File.exists?(filename), "Master, not current, file should exist: #{filename}"
    end

  end
end