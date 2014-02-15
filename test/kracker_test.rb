require 'test_helper'

class KrackerTest < Kracker::KrackerTestCase

  def test_same_elements

    master_data = array_of_elements
    current_data = array_of_elements

    analysis = analyze_data_sets(master_data, current_data)

    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'

  end

  def test_one_size_different
    master_data = array_of_elements_small
    current_data = array_of_elements_small
    current_data.first['width'] = current_data.first['width'] + 13

    analysis = analyze_data_sets(master_data, current_data)

    assert_equal 1, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 1, analysis[:not_in_current].count, 'results of data analysis: not_in_current'

  end

end