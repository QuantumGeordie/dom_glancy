require 'test_helper'

class KrackerTest < Kracker::KrackerTestCase
  def setup
    prep_locations_for_test
    make_master_file('junk', array_of_elements_small)
    @kracker_object = KrackerClassForStubbing.new
  end

  def teardown
    delete_test_locations
  end

  def test_kracker__pass
    @kracker_object.stubs(:perform_mapping_operation).returns(array_of_elements_small)
    mapping_results = @kracker_object.page_map_same?('junk')

    assert mapping_results[0], mapping_results[1]
  end

  def test_kracker__fail_one_new_element
    current_data = array_of_elements_small << single_element_hash
    @kracker_object.stubs(:perform_mapping_operation).returns(current_data)
    mapping_results = @kracker_object.page_map_same?('junk')

    refute mapping_results[0], mapping_results[1]
    assert_match 'Elements not in master: 1', mapping_results[1], mapping_results[1]
    assert_match 'Elements not in current: 0', mapping_results[1], mapping_results[1]
    assert_match 'Changed elements: 0', mapping_results[1], mapping_results[1]
  end

  def make_master_file(test_root, data)
    filename = Kracker.master_filename(test_root)
    yaml_data = data.to_yaml
    File.open(filename, 'w') { |file| file.write(yaml_data) }
  end

end
