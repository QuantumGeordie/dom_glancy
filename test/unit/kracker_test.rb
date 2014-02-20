require 'test_helper'

class KrackerTest < Kracker::KrackerTestCase
  def setup
    @test_root = 'elbow'
    prep_locations_for_test
    make_master_test_file(@test_root, array_of_elements_small)
    @kracker_object = KrackerClassForStubbing.new
  end

  def teardown
    delete_test_locations
  end

  def test_kracker__missing_master
    this_test_root = 'not_elbow'
    blessing_copy_string = "cp #{Kracker.current_filename(this_test_root)} #{Kracker.master_filename(this_test_root)}"

    @kracker_object.stubs(:perform_mapping_operation).returns(array_of_elements_small)
    mapping_results = @kracker_object.page_map_same?(this_test_root)

    refute mapping_results[0], 'test should fail because no master'
    assert_match 'Master file does not exist', mapping_results[1], 'failure message when no master'
    assert_match blessing_copy_string, mapping_results[1], 'blessing copy string should be in the error message'

    `#{blessing_copy_string}`
    @kracker_object.stubs(:perform_mapping_operation).returns(array_of_elements_small)

    mapping_results = @kracker_object.page_map_same?(this_test_root)
    assert mapping_results[0], 'test should now pass with copied master'

  end

  def test_kracker__pass
    @kracker_object.stubs(:perform_mapping_operation).returns(array_of_elements_small)
    mapping_results = @kracker_object.page_map_same?(@test_root)

    assert mapping_results[0], mapping_results[1]
  end

  def test_kracker__fail_one_new_element
    blessing_copy_string = "cp #{Kracker.current_filename(@test_root)} #{Kracker.master_filename(@test_root)}"


    current_data = array_of_elements_small << single_element_hash
    @kracker_object.stubs(:perform_mapping_operation).returns(current_data)
    mapping_results = @kracker_object.page_map_same?(@test_root)

    refute mapping_results[0], 'page same results should be false'

    assert_match 'Elements not in master: 1',  mapping_results[1], 'error message contents'
    assert_match 'Elements not in current: 0', mapping_results[1], 'error message contents'
    assert_match 'Changed elements: 0',        mapping_results[1], 'error message contents'

    assert_match "current: #{Kracker.current_filename(@test_root)}", mapping_results[1], 'error message contents'
    assert_match "master: #{Kracker.master_filename(@test_root)}",   mapping_results[1], 'error message contents'
    assert_match "difference: #{Kracker.diff_filename(@test_root)}", mapping_results[1], 'error message contents'

    assert_match blessing_copy_string, mapping_results[1], 'blessing copy string should be in the error message'

    `#{blessing_copy_string}`

    @kracker_object.stubs(:perform_mapping_operation).returns(current_data)
    mapping_results = @kracker_object.page_map_same?(@test_root)

    assert mapping_results[0], 'should pass now that the blessing copy string has been run'

  end

  def make_master_test_file(test_root, data)
    filename = Kracker.master_filename(test_root)
    yaml_data = data.to_yaml
    File.open(filename, 'w') { |file| file.write(yaml_data) }
  end

end
