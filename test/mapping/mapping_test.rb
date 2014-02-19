require 'mapping_test_helper'

class MappingTest < Kracker::KrackerMappingTestCase

  def setup
    delete_contents_from_kracker_locations
  end

  def teardown
    delete_contents_from_kracker_locations
  end

  def test_mapping
    page.visit '/kracker'
    assert page.has_content?('Kracker'), 'looking for content on page'
    assert page.has_content?('Index'), 'looking for content on page'

    js = 'return kracker.treeUp();'
    results = page.driver.browser.execute_script(js)

    assert_equal 7, results.length, 'number of elements returned from mapping call'
  end

  def test_full_mapping__same
    page.visit '/kracker'

    map_current_page_and_save_as_master('kracker_index')

    same, msg = page_map_same?('kracker_index')

    assert same, msg
  end

  def test_full_mapping__different
    page.visit '/kracker'

    map_current_page_and_save_as_master('kracker_index')

    add_centered_element('Back In Black')

    same, msg = page_map_same?('kracker_index')

    refute same, msg
  end

  private

  def map_current_page_and_save_as_master(test_root)
    js = "return kracker.treeUp();"
    map_data = page.driver.browser.execute_script(js)
    File.open(Kracker.master_filename(test_root), 'w') { |file| file.write(map_data.to_yaml) }
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
end
