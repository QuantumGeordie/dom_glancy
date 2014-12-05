require 'test_helper'

class AnalysisTest < DomGlancy::DomGlancyTestCase

  def test_same_elements
    master_data = array_of_elements
    current_data = array_of_elements

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert analysis[:same], 'results of data analysis.same'
  end

  def test_one_id_different
    master_data = array_of_elements_small
    current_data = array_of_elements_small
    current_data.first['id'] = 'some-new-id'

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 1, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 1, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    refute analysis[:same], 'results of data analysis.same'
  end

  def test_one_new_element
    master_data = array_of_elements
    current_data = array_of_elements
    current_data << single_element_hash

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 1, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    refute analysis[:same], 'results of data analysis.same'
  end

  def test_two_changed
    master_data = array_of_elements
    current_data = array_of_elements
    current_data[0]['height'] = current_data[0]['height'] + 16
    current_data[1]['width'] = current_data[1]['width'] + 25

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 2, analysis[:changed_element_pairs].count, 'changed element pairs'
    refute analysis[:same], 'results of data analysis.same'

  end

  def test_one_changed_less_than_similarity_factor
    master_data = array_of_elements
    current_data = array_of_elements

    current_data[1]['height'] = current_data[1]['height'] + 3

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 0, analysis[:changed_element_pairs].count, 'changed element pairs'
    assert analysis[:same], 'results of data analysis.same'
  end

  def test_one_changed_one_missing_one_added
    master_data = array_of_elements
    current_data = array_of_elements

    current_data[0]['height'] = current_data[0]['height'] + 23   ## the one changed (by more than similarity factor)
    current_data[1]['height'] = current_data[1]['height'] + 3    ## the one changed (by less than similarity factor and therefor not counted)
    current_data.delete_at(5)                                    ## the one missing
    current_data << single_element_hash                          ## the one added

    analysis = @dom_glancy.analyze(master_data, current_data)

    assert_equal 1, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 1, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 1, analysis[:changed_element_pairs].count, 'changed element pairs'
    refute analysis[:same], 'results of data analysis.same'
  end

  def test_huge_list_of_similarly_named_elements
    master_data  = travis_local_generated_master
    current_data = travis_generated_current

    analysis = @dom_glancy.analyze(master_data, current_data)
    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 0, analysis[:changed_element_pairs].count, 'changed element pairs'
    assert analysis[:same], 'results of data analysis.same'
  end

  def test_huge_another_list_of_similarly_named_elements
    master_data  = travis_local_generated_master_2
    current_data = travis_generated_current_2

    analysis = @dom_glancy.analyze(master_data, current_data)

    ## real difference that was found on travis with the INPUT tags being different styles/sizes if not css-styled
    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 1, analysis[:changed_element_pairs].count, 'changed element pairs'
    refute analysis[:same], 'results of data analysis.same'
  end

end
