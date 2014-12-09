require 'test_helper'

class LocationTest < DomGlancyTestCase

  def setup
    super
    prep_locations_for_test
  end

  def teardown
    delete_test_locations
  end

  def test_locations
    assert_equal File.join(@locations_root, 'masters'), DomGlancy.configuration.master_file_location  , 'master file location value'
    assert_equal File.join(@locations_root, 'current'), DomGlancy.configuration.current_file_location , 'current file location value'
    assert_equal File.join(@locations_root, 'diff'),    DomGlancy.configuration.diff_file_location    , 'difference file location value'

    assert Dir.exist?(DomGlancy.configuration.master_file_location)  , 'master file location created'
    assert Dir.exist?(DomGlancy.configuration.current_file_location)  , 'current file location created'
    assert Dir.exist?(DomGlancy.configuration.diff_file_location)  , 'difference file location created'
  end

end
