require 'test_helper'

class PageMapperTest < DomGlancyTestCase

  def setup
    prep_locations_for_test
  end

  def teardown
    delete_test_locations
  end

  def test_file_mapper_run
    test_name = 'gram_parsons'

    file_mapper = DomGlancy::PageMapper.new
    file_mapper.stubs(:map_page).returns(mapping_json)
    result = file_mapper.run(test_name)

    assert result[0], 'Mapping result should be true to indicate successful mapping'
    assert_equal '', result[1], 'empty string error message from a successful mapping'

    files_in_current_dir = Dir[File.join(DomGlancy.configuration.current_file_location, '*')]
    assert_equal 1, files_in_current_dir.count
    assert_equal files_in_current_dir.first, File.join(DomGlancy.configuration.current_file_location, "#{test_name}.yaml")
  end
end
