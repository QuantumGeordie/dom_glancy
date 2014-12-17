require 'test_helper'

class FileNameBuilderTest < DomGlancyTestCase
  def setup
    locations_root = '/path/to/dom_glancy/files/'

    DomGlancy.configure do |config|
      config.master_file_location  = File.join(locations_root, 'masters')
      config.current_file_location = File.join(locations_root, 'current')
      config.diff_file_location    = File.join(locations_root, 'diff')
    end
  end

  def test_filenames
    fnb = DomGlancy::FileNameBuilder.new('test_of_the_year')
    assert_equal '/path/to/dom_glancy/files/masters/test_of_the_year_master.yaml', fnb.master
    assert_equal '/path/to/dom_glancy/files/current/test_of_the_year.yaml',        fnb.current
    assert_equal '/path/to/dom_glancy/files/diff/test_of_the_year_diff.html',      fnb.diff
  end

  def test_filenames__no_test_root
    fnb = DomGlancy::FileNameBuilder.new

    assert_equal '/path/to/dom_glancy/files/masters/_master.yaml', fnb.master
    assert_equal '/path/to/dom_glancy/files/current/.yaml', fnb.current
    assert_equal '/path/to/dom_glancy/files/diff/_diff.html', fnb.diff
  end
end
