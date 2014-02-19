require 'mapping_test_helper'

class MappingTest < Kracker::KrackerMappingTestCase

  def test_mapping
    page.visit '/kracker'
    assert page.has_content?('Kracker'), 'looking for content on page'
    assert page.has_content?('Index'), 'looking for content on page'

    js = "return kracker.treeUp();"

    results = page.driver.browser.execute_script(js)

    assert_equal 3, results.length, 'number of elements returned from mapping call'
  end

end
