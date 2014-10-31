require 'test_helper'

class LocationTest < DomGlancy::DomGlancyTestCase

  def setup
    prep_locations_for_test
  end

  def teardown
    delete_test_locations
  end

  def test_locations
    assert_equal File.join(@locations_root, 'masters'), DomGlancy.master_file_location  , 'master file location value'
    assert_equal File.join(@locations_root, 'current'), DomGlancy.current_file_location , 'current file location value'
    assert_equal File.join(@locations_root, 'diff'),    DomGlancy.diff_file_location    , 'difference file location value'

    assert Dir.exist?(DomGlancy.master_file_location)  , 'master file location created'
    assert Dir.exist?(DomGlancy.current_file_location)  , 'current file location created'
    assert Dir.exist?(DomGlancy.diff_file_location)  , 'difference file location created'
  end

end
