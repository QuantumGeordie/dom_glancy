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

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

require File.expand_path('../test_app/config/environment', __FILE__)

require 'minitest/autorun'

require 'awesome_print'

require 'capybara'
require 'capybara/dsl'
require 'capybara/rails'
require 'selenium-webdriver'

require 'page_objects'

test_objects_location = File.expand_path('../test_objects/*.rb', __FILE__)
Dir[test_objects_location].each { |f| require f }

test_helper_location = File.expand_path('../test_helpers/**/*.rb', __FILE__)
Dir[test_helper_location].each { |f| require f }

Capybara.default_driver = :selenium

class SeleniumTestCase < Minitest::Test
  include TestObjects
  include TestHelpers::Location
  include TestHelpers::Artifacts

  include Capybara::DSL

  def setup
    @dom_glancy = DomGlancy::DomGlancy.new
    delete_contents_from_dom_glancy_locations
    initialize_browser_size_for_test
  end

  def teardown
    # delete_contents_from_dom_glancy_locations
  end

  def initialize_browser_size_for_test
    @browser_dimensions = ENV['BROWSER_SIZE'] || '960x1000'
    if @browser_dimensions
      @starting_dimensions = get_current_browser_dimensions
      w = @browser_dimensions.split('x')[0]
      h = @browser_dimensions.split('x')[1]
      resize_browser(w, h)
    end
  end

  def visit_index
    PageObjects::DomGlancy::IndexPage.visit
  end

  def remove_about_element
    js = <<-JS
      var element = document.getElementById('js-kr--nav');
      element.parentNode.removeChild(element);
    JS

    page.driver.browser.execute_script(js)
  end

  def resize_about_element(add_to_width)
    js = <<-JS
      var element = document.getElementById('js--about');
      var width = element.clientWidth + #{add_to_width};
      element.style.width = width + 'px';
    JS

    page.driver.browser.execute_script(js)
  end

  def add_to_top(text_content)
    # insertBefore
    js = <<-JS
      var el = document.createElement('div');
      el.style.textAlign = 'center';
      el.style.fontSize = '0.8em';
      el.style.width = '400px';
      el.style.height = '20px';
      el.style.marginLeft = 'auto';
      el.style.marginRight = 'auto';
      el.id = 'hack-element';
      el.textContent = '#{text_content}';
      el.style.backgroundColor = '#ff0000';

      var bod = document.getElementsByTagName('body')[0];
      var opts = document.getElementsByClassName('lot_o_h2s')[0];

      bod.insertBefore(el, opts);
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

  def resize_browser(width, height)
    page.driver.browser.manage.window.resize_to(width.to_i, height.to_i)
  end

  def get_current_browser_dimensions
    page.driver.browser.manage.window.size
  end
  end
