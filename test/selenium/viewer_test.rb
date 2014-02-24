require 'selenium_test_helper'

class MappingTest < Kracker::SeleniumTestCase

  def test_navigation
    index_page = visit_index
    config_page = index_page.navigation.config!

    assert_equal Kracker.master_file_location.to_s, config_page.master, 'master file location'
    assert_equal Kracker.current_file_location.to_s, config_page.current, 'current file location'
    assert_equal Kracker.diff_file_location.to_s, config_page.diffs, 'difference file location'

    new_page = config_page.navigation.new_page!
    assert page.has_content?('NEW MASTERS!!'), 'new masters page needs some content.'

    artifacts_page = new_page.navigation.artifacts!
    assert page.has_content?('ARTIFACTS, YO'), 'artifacts page needs some content.'

    about_page = artifacts_page.navigation.about!
    assert page.has_content?('ABOUT PAGE'), 'stupid about page right now.'

  end



end
