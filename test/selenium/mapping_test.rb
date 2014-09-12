require 'selenium_test_helper'

class MappingTest < Kracker::SeleniumTestCase

  def test_full_mapping__same
    visit_index

    map_current_page_and_save_as_master('kracker_index')

    same, msg = page_map_same?('kracker_index')

    assert same, msg
    assert_artifacts_on_same('kracker_index')
  end

  def test_mapping__no_master
    visit_index
    same, msg = page_map_same?('poop')
    refute same, msg
    assert_match 'Master file does not exist', msg, 'the missing master error message'
  end

  def test_full_mapping__one_added__clear
    visit_index

    map_current_page_and_save_as_master('kracker_index')

    add_centered_element('Back In Black')

    same, msg = page_map_same?('kracker_index')

    refute same, msg

    index_page = visit_index

    assert_equal 1, index_page.files.count, 'number of difference files'
    assert_match 'kracker_index_diff.html', index_page.files.first.text, 'file name displayed'

    index_page.files.first.find('a').click
    show_page = PageObjects::Kracker::ShowPage.new

    assert_equal 1, show_page.not_master.count, 'elements listed as not in master'
    assert_equal 0, show_page.not_current.count, 'elements listed as not in current'
    assert_equal 0, show_page.changed.count, 'elements listed as changed'

    assert_artifacts_on_difference('kracker_index')

    index_page = show_page.navigation.clear_results!
    assert_equal 0, index_page.files.count, 'should be no difference files now'
  end

  def test_full_mapping__one_missing__bless
    visit_index

    map_current_page_and_save_as_master('kracker_index')

    remove_about_element

    same, msg = page_map_same?('kracker_index')

    refute same, msg

    index_page = visit_index

    assert_equal 1, index_page.files.count, 'number of difference files'
    assert_match 'kracker_index_diff.html', index_page.files.first.text, 'file name displayed'

    index_page.files.first.find('a').click
    show_page = PageObjects::Kracker::ShowPage.new

    assert_equal 0, show_page.not_master.count, 'elements listed as not in master'
    assert_equal 8, show_page.not_current.count, 'elements listed as not in current'
    assert_equal 5, show_page.changed.count, 'elements listed as changed'

    assert_artifacts_on_difference('kracker_index')

    index_page = show_page.bless!
    assert_equal 0, index_page.files.count, 'number of difference files'
  end

  def test_non_kracker_page__pass
    local_page = PageObjects::Kracker::LocalIndexPage.visit

    map_current_page_and_save_as_master('test_page')

    same, msg = page_map_same?('test_page')

    assert same, msg

    assert_artifacts_on_same 'test_page'
  end

  def test_non_kracker_page__fail__size_change
    local_page = PageObjects::Kracker::LocalIndexPage.visit

    map_current_page_and_save_as_master('test_page')

    starting_dimensions = get_current_browser_dimensions
    w = starting_dimensions.width + 100
    h = starting_dimensions.height

    resize_browser(w, h)

    same, msg = page_map_same?('test_page')

    refute same, msg

    assert_artifacts_on_difference 'test_page'
  end

  private

  def map_current_page_and_save_as_master(test_root)
    map_data = perform_mapping_operation
    File.open(Kracker.master_filename(test_root), 'w') { |file| file.write(map_data.to_yaml) }
  end

end
