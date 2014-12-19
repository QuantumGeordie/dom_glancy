require 'test_helper'

class MapFileTest < DomGlancyTestCase
  require 'json'

  def setup
    prep_locations_for_test

    @test_root = 'alberto_moreno'
    @map_file  = DomGlancy::MapFile.new
    @fnb       = DomGlancy::FileNameBuilder.new(@test_root)
    @filename = @fnb.master
  end

  def teardown
    delete_test_locations
  end

  def test_read__no_file
    results = @map_file.read(@filename)

    refute results[0]
    assert_match 'Error reading data from file', results[1]
    assert_match @filename, results[1]
    assert_nil results[2]
  end

  def test_read
    raw_data = array_of_elements_small
    File.open(@filename, 'w') { |file| file.write(raw_data.to_json) }

    results = @map_file.read(@filename)

    assert results[0]
    assert_equal '', results[1]
    assert_equal 2,  results[2].count

    assert_equal '12',   results[2][0]['id']
    assert_equal 238,    results[2][0]['height']
    assert_equal true,   results[2][0]['visible']
    assert_equal 'DIV',  results[2][0]['tag']
    assert_equal 720,    results[2][0]['width']
    assert_equal 'grid', results[2][0]['class']
    assert_equal 43,     results[2][0]['left']
    assert_equal 14,     results[2][0]['top']
  end
end
