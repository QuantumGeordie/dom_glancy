require 'test_helper'

class LocationTest < Kracker::KrackerTestCase

  def setup
    prep_locations_for_test
  end

  def teardown
    delete_test_locations
  end

  def test_locations
    assert_equal File.join(@locations_root, 'masters'), Kracker.master_file_location  , 'master file location value'
    assert_equal File.join(@locations_root, 'current'), Kracker.current_file_location , 'current file location value'
    assert_equal File.join(@locations_root, 'diff'),    Kracker.diff_file_location    , 'difference file location value'

    assert Dir.exist?(Kracker.master_file_location)  , 'master file location created'
    assert Dir.exist?(Kracker.current_file_location)  , 'current file location created'
    assert Dir.exist?(Kracker.diff_file_location)  , 'difference file location created'
  end

end
