require 'selenium_test_helper'

class MappingTest < SeleniumTestCase

  def test_full_mapping__same
    visit_index

    map_current_page_and_save_as_master('dom_glancy_index')

    same, msg = @dom_glancy.page_map_same?('dom_glancy_index')

    assert same, msg
    assert_artifacts_on_same('dom_glancy_index')
  end

  def test_mapping__no_master
    visit_index
    same, msg = @dom_glancy.page_map_same?('poop')
    refute same, msg
    assert_match 'Master file does not exist', msg, 'the missing master error message'
  end

  def test_full_mapping__one_added__clear
    visit_index

    map_current_page_and_save_as_master('dom_glancy_index')

    add_centered_element('Back In Black')

    same, msg = @dom_glancy.page_map_same?('dom_glancy_index')

    refute same, msg

    index_page = visit_index

    assert_equal 1, index_page.files.count, 'number of difference files'
    assert_match 'dom_glancy_index', index_page.files.first.text, 'file name displayed'

    index_page.files.first.find('a').click
    show_page = PageObjects::DomGlancy::ShowPage.new

    assert_equal 1, show_page.not_master.count, 'elements listed as not in master'
    assert_equal 0, show_page.not_current.count, 'elements listed as not in current'
    assert_equal 0, show_page.changed.count, 'elements listed as changed'

    assert_artifacts_on_difference('dom_glancy_index')

    index_page = show_page.navigation.clear_results!
    assert_equal 0, index_page.files.count, 'should be no difference files now'
  end

  def test_full_mapping__one_missing__bless
    visit_index

    map_current_page_and_save_as_master('dom_glancy_index')

    remove_about_element

    same, msg = @dom_glancy.page_map_same?('dom_glancy_index')

    refute same, msg

    index_page = visit_index

    assert_equal 1, index_page.files.count, 'number of difference files'
    assert_match 'dom_glancy_index', index_page.files.first.text, 'file name displayed'

    index_page.files.first.find('a').click
    show_page = PageObjects::DomGlancy::ShowPage.new

    assert_equal 0,  show_page.not_master.count,  'elements listed as not in master'
    assert_equal 7,  show_page.not_current.count, 'elements listed as not in current'
    assert_equal 11, show_page.changed.count,     'elements listed as changed'

    assert_artifacts_on_difference('dom_glancy_index')

    index_page = show_page.bless!
    assert_equal 0, index_page.files.count, 'number of difference files'
  end

  def test_non_dom_glancy_page__pass
    local_page = PageObjects::DomGlancy::LocalIndexPage.visit

    map_current_page_and_save_as_master('test_page')

    same, msg = @dom_glancy.page_map_same?('test_page')

    assert same, msg

    assert_artifacts_on_same 'test_page'
  end

  def test_non_dom_glancy_page__fail__size_change
    local_page = PageObjects::DomGlancy::LocalIndexPage.visit

    map_current_page_and_save_as_master('test_page')

    starting_dimensions = get_current_browser_dimensions
    w = starting_dimensions.width + 100
    h = starting_dimensions.height

    resize_browser(w, h)

    same, msg = @dom_glancy.page_map_same?('test_page')

    refute same, msg

    assert_artifacts_on_difference 'test_page'
  end

  private

  def map_current_page_and_save_as_master(test_root)
    map_data = @dom_glancy.perform_mapping_operation
    File.open(DomGlancy::DomGlancy.master_filename(test_root), 'w') { |file| file.write(map_data.to_yaml) }
  end

end
