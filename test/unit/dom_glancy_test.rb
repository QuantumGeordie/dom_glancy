require 'test_helper'

class DomGlancyTest < DomGlancy::DomGlancyTestCase

  def setup
    super
    @test_root = 'elbow'
    prep_locations_for_test
    make_master_test_file(@test_root, array_of_elements_small)
  end

  def teardown
    delete_test_locations
  end

  def test_dom_glancy__missing_master
    this_test_root = 'not_elbow'
    blessing_copy_string = "cp #{DomGlancy::DomGlancy.current_filename(this_test_root)} #{DomGlancy::DomGlancy.master_filename(this_test_root)}"

    @dom_glancy.stubs(:perform_mapping_operation).returns(array_of_elements_small)
    mapping_results = @dom_glancy.page_map_same?(this_test_root)

    refute mapping_results[0], 'test should fail because no master'
    assert_match 'Master file does not exist', mapping_results[1], 'failure message when no master'
    assert_match blessing_copy_string, mapping_results[1], 'blessing copy string should be in the error message'

    `#{blessing_copy_string}`
    @dom_glancy.stubs(:perform_mapping_operation).returns(array_of_elements_small)

    mapping_results = @dom_glancy.page_map_same?(this_test_root)
    assert mapping_results[0], 'test should now pass with copied master'
  end

  def test_dom_glancy__pass
    @dom_glancy.stubs(:perform_mapping_operation).returns(array_of_elements_small)
    mapping_results = @dom_glancy.page_map_same?(@test_root)

    assert mapping_results[0], mapping_results[1]
  end

  def test_dom_glancy__fail_one_new_element
    blessing_copy_string = "cp #{DomGlancy::DomGlancy.current_filename(@test_root)} #{DomGlancy::DomGlancy.master_filename(@test_root)}"

    current_data = array_of_elements_small << single_element_hash
    @dom_glancy.stubs(:perform_mapping_operation).returns(current_data)
    mapping_results = @dom_glancy.page_map_same?(@test_root)

    refute mapping_results[0], 'page same results should be false'

    assert_match 'Elements not in master: 1',  mapping_results[1], 'error message contents'
    assert_match 'Elements not in current: 0', mapping_results[1], 'error message contents'
    assert_match 'Changed elements: 0',        mapping_results[1], 'error message contents'

    assert_match "current: #{DomGlancy::DomGlancy.current_filename(@test_root)}", mapping_results[1], 'error message contents'
    assert_match "master: #{DomGlancy::DomGlancy.master_filename(@test_root)}",   mapping_results[1], 'error message contents'
    assert_match "difference: #{DomGlancy::DomGlancy.diff_filename(@test_root)}", mapping_results[1], 'error message contents'

    assert_match blessing_copy_string, mapping_results[1], 'blessing copy string should be in the error message'

    files_in_diff_location = Dir[File.join(DomGlancy::DomGlancy.diff_file_location, '*')]
    assert_equal 4, files_in_diff_location.count, 'the number of files in the diff location after a failure.'

    `#{blessing_copy_string}`

    @dom_glancy.stubs(:perform_mapping_operation).returns(current_data)
    mapping_results = @dom_glancy.page_map_same?(@test_root)

    assert mapping_results[0], 'should pass now that the blessing copy string has been run'

  end

  def make_master_test_file(test_root, data)
    filename = DomGlancy::DomGlancy.master_filename(test_root)
    yaml_data = data.to_yaml
    File.open(filename, 'w') { |file| file.write(yaml_data) }
  end

end
