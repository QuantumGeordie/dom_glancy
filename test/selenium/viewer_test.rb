require 'selenium_test_helper'

class ViewerTest < DomGlancy::SeleniumTestCase

  def test_navigation
    index_page = visit_index
    config_page = index_page.navigation.config!

    assert_equal DomGlancy::DomGlancy.master_file_location.to_s, config_page.master, 'master file location'
    assert_equal DomGlancy::DomGlancy.current_file_location.to_s, config_page.current, 'current file location'
    assert_equal DomGlancy::DomGlancy.diff_file_location.to_s, config_page.diffs, 'difference file location'

    new_page = config_page.navigation.new_page!
    assert page.has_content?('do not have a corresponding master file in the expected file location'), 'new masters page content.'

    about_page = new_page.navigation.about!
    assert page.has_content?('Add this line to your'), 'about page line from README.md'

    index_page = about_page.navigation.home!
  end

end
