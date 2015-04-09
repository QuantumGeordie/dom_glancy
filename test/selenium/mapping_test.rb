require 'selenium_test_helper'

class MappingTest < SeleniumTestCase

  def test_slight_shift_down
    visit_local_page

    map_current_page_and_save_as_master('dom_glancy_index__shifted')

    add_to_top('booty')

    same, msg = @dom_glancy.page_map_same?('dom_glancy_index__shifted')

    refute same, msg

    assert_match 'Elements not in master: 1', msg
    assert_match 'Elements not in current: 1', msg
    assert_match 'Changed elements: 32', msg

    assert_artifacts_on_difference('dom_glancy_index__shifted')
  end

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

    show_page.toggle

    assert_equal 1, show_page.not_master.count, 'elements listed as not in master'
    assert_equal 0, show_page.not_current.count, 'elements listed as not in current'
    assert_equal 0, show_page.changed.count, 'elements listed as changed'

    assert_artifacts_on_difference('dom_glancy_index')

    index_page = show_page.navigation.clear_results!
    assert page.has_content? 'There are currently no difference files to be displayed.'
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

    show_page.toggle
    
    assert_equal 0,  show_page.not_master.count,  'elements listed as not in master'
    assert_equal 11, show_page.not_current.count, 'elements listed as not in current'
    assert_equal 4,  show_page.changed.count,     'elements listed as changed'

    assert_artifacts_on_difference('dom_glancy_index')

    index_page = show_page.bless!
    assert page.has_content?('There are currently no difference files to be displayed.'), 'Message saying no difference files right now.'
  end

  def test_mapping__similarity
    visit_local_page

    add_centered_element('Buzzcocks')

    map_current_page_and_save_as_master('similarity')

    assert_equal 15, DomGlancy.configuration.similarity, 'Dom Glancy similarity value'

    resize_hack_element(15)    # increase the size of the about element by the similarity amount and it should be same

    same, msg = @dom_glancy.page_map_same?('similarity')
    assert same, msg
    assert_equal '', msg

    resize_hack_element(1)     # increase the size of the about element by 1 more pixel and it should be NOT same

    same, msg = @dom_glancy.page_map_same?('similarity')
    refute same, msg

    assert_match 'Elements not in master: 0',  msg
    assert_match 'Elements not in current: 0', msg
    assert_match 'Changed elements: 1',        msg
  end

  def test_non_dom_glancy_page__pass
    local_page = visit_local_page

    map_current_page_and_save_as_master('test_page')

    same, msg = @dom_glancy.page_map_same?('test_page')

    assert same, msg

    assert_artifacts_on_same 'test_page'
  end

  def test_non_dom_glancy_page__fail__size_change
    local_page = visit_local_page

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
    file_mapper = DomGlancy::PageMapper.new
    map_data = file_mapper.send(:map_page)
    File.open(DomGlancy::FileNameBuilder.new(test_root).master, 'w') { |file| file.write(map_data.to_yaml) }
  end

end
