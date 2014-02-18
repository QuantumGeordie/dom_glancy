require 'test_helper'

class LocationTest < Kracker::KrackerTestCase

  def setup
    prep_locations_for_test
  end

  def teardown
    clean_up
  end

  def test_locations
    assert_equal File.join(@locations_root, 'masters'), Kracker.master_file_location  , 'master file location value'
    assert_equal File.join(@locations_root, 'current'), Kracker.current_file_location , 'current file location value'
    assert_equal File.join(@locations_root, 'diff'),    Kracker.diff_file_location    , 'difference file location value'

    assert Dir.exist?(Kracker.master_file_location)  , 'master file location created'
    assert Dir.exist?(Kracker.current_file_location)  , 'current file location created'
    assert Dir.exist?(Kracker.diff_file_location)  , 'difference file location created'
  end

  private

  def prep_locations_for_test
    @locations_root = File.expand_path('..', __FILE__)

    Kracker.master_file_location  = File.join(@locations_root, 'masters')
    Kracker.current_file_location = File.join(@locations_root, 'current')
    Kracker.diff_file_location    = File.join(@locations_root, 'diff')

    Kracker.create_comparison_directories
  end

  def clean_up
    FileUtils.rm_rf Kracker.master_file_location
    FileUtils.rm_rf Kracker.current_file_location
    FileUtils.rm_rf Kracker.diff_file_location
  end
end
