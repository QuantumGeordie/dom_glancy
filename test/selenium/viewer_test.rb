require 'selenium_test_helper'

class ViewerTest < SeleniumTestCase

  def test_navigation
    index_page = visit_index
    config_page = index_page.navigation.config!

    assert_equal DomGlancy.configuration.master_file_location.to_s, config_page.master, 'master file location'
    assert_equal DomGlancy.configuration.current_file_location.to_s, config_page.current, 'current file location'
    assert_equal DomGlancy.configuration.diff_file_location.to_s, config_page.diffs, 'difference file location'

    new_page = config_page.navigation.new_page!
    assert page.has_content?('There are no new test files to display.'), 'new masters page content.'

    about_page = new_page.navigation.about!
    assert page.has_content?('Info about Dom Glancy can be found'), 'about page content.'

    index_page = about_page.navigation.home!
  end

  def test_make_master
    names = %w(steven_gerrard jordan_henderson adam_lallana)
    names.each { |name| File.open(DomGlancy::FileNameBuilder.new(name).current, 'w') { |f| f.write '' } }

    index_page = visit_index
    new_tests_page = index_page.navigation.new_page!

    assert_equal names.count, new_tests_page.files.count

    new_tests_page.files.each do |file|
      assert_includes names, file.name.text, 'filename displayed'
    end

    assert_equal names.count, Dir[File.join(DomGlancy.configuration.current_file_location, '*.yaml')].count
    assert_equal 0,           Dir[File.join(DomGlancy.configuration.master_file_location, '*.yaml')].count

    new_tests_page = new_tests_page.files.first.make_master
    assert_equal names.count - 1, new_tests_page.files.count
    assert_equal names.count,     Dir[File.join(DomGlancy.configuration.current_file_location, '*.yaml')].count
    assert_equal 1,               Dir[File.join(DomGlancy.configuration.master_file_location, '*.yaml')].count

    new_tests_page = new_tests_page.files.first.delete
    assert_equal names.count - 2, new_tests_page.files.count
    assert_equal names.count - 1, Dir[File.join(DomGlancy.configuration.current_file_location, '*.yaml')].count
    assert_equal 1,               Dir[File.join(DomGlancy.configuration.master_file_location, '*.yaml')].count
  end
end
