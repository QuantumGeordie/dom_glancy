require 'test_helper'

class AnalyzerTest < DomGlancyTestCase

  def test_same_elements
    master_data = array_of_elements
    current_data = array_of_elements

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 0, analysis[:not_in_master].count,  'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert analysis[:same],                          'results of data analysis.same'
  end

  def test_one_id_different
    master_data = array_of_elements_small
    current_data = array_of_elements_small
    current_data.first['id'] = 'some-new-id'

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 1, analysis[:not_in_master].count,  'results of data analysis: not_in_master'
    assert_equal 1, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    refute analysis[:same],                          'results of data analysis.same'
  end

  def test_one_new_element
    master_data = array_of_elements
    current_data = array_of_elements
    current_data << single_element_hash

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 1, analysis[:not_in_master].count,  'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    refute analysis[:same],                          'results of data analysis.same'
  end

  def test_two_changed
    master_data = array_of_elements
    current_data = array_of_elements
    current_data[0]['height'] = current_data[0]['height'] + 16
    current_data[1]['width'] = current_data[1]['width'] + 25

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 0, analysis[:not_in_master].count,         'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count,        'results of data analysis: not_in_current'
    assert_equal 2, analysis[:changed_element_pairs].count, 'changed element pairs'
    assert_equal 2, analysis[:changed_master].count,        'changed master elements'
    refute analysis[:same],                                 'results of data analysis.same'
  end

  def test_one_changed_less_than_similarity_factor
    master_data = array_of_elements
    current_data = array_of_elements

    current_data[1]['height'] = current_data[1]['height'] + 3

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 0, analysis[:not_in_master].count,         'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count,        'results of data analysis: not_in_current'
    assert_equal 0, analysis[:changed_element_pairs].count, 'changed element pairs'
    assert analysis[:same],                                 'results of data analysis.same'
  end

  def test_one_changed_one_missing_one_added
    master_data = array_of_elements
    current_data = array_of_elements

    current_data[0]['height'] = current_data[0]['height'] + 23   ## the one changed (by more than similarity factor)
    current_data[1]['height'] = current_data[1]['height'] + 3    ## the one changed (by less than similarity factor and therefor not counted)
    current_data.delete_at(5)                                    ## the one missing
    current_data << single_element_hash                          ## the one added

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    assert_equal 1, analysis[:not_in_master].count,          'results of data analysis: not_in_master'
    assert_equal 1, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 1, analysis[:changed_element_pairs].count, 'changed element pairs'
    refute analysis[:same], 'results of data analysis.same'
  end

  def test_huge_list_of_similarly_named_elements
    master_data  = travis_local_generated_master
    current_data = travis_generated_current

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze
    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 0, analysis[:changed_element_pairs].count, 'changed element pairs'
    assert analysis[:same], 'results of data analysis.same'
  end

  def test_huge_another_list_of_similarly_named_elements
    master_data  = travis_local_generated_master_2
    current_data = travis_generated_current_2

    analysis = DomGlancy::Analyzer.new(master_data, current_data).analyze

    ## real difference that was found on travis with the INPUT tags being different styles/sizes if not css-styled
    assert_equal 0, analysis[:not_in_master].count, 'results of data analysis: not_in_master'
    assert_equal 0, analysis[:not_in_current].count, 'results of data analysis: not_in_current'
    assert_equal 1, analysis[:changed_element_pairs].count, 'changed element pairs'
    refute analysis[:same], 'results of data analysis.same'
  end

  def test_large_change_set
    test_root = 'suso'
    file_1 = File.expand_path('../../test_objects/options_file_1.yaml', __FILE__)
    file_2 = File.expand_path('../../test_objects/options_file_2.yaml', __FILE__)

    result, msg, current_data = DomGlancy::MapFile.new.read(file_1)
    result, msg, master_data  = DomGlancy::MapFile.new.read(file_2)

    analyzer = ::DomGlancy::Analyzer.new(master_data, current_data, test_root)

    analysis_data = analyzer.analyze

    # ap analysis_data

    refute analysis_data[:same]
    assert_equal 0,  analysis_data[:not_in_master].count,         'not master count'
    assert_equal 39, analysis_data[:not_in_current].count,        'not current count'
    assert_equal 47, analysis_data[:changed_element_pairs].count, 'changed element pairs count'
    assert_equal 47, analysis_data[:changed_master].count,        'changed master count'
  end

  def test_from_changed_h1_sets
    test_root = 'jordan_henderson'
    master_data  = set_1_h1_changes
    current_data = set_2_h1_changes

    analyzer = ::DomGlancy::Analyzer.new(master_data, current_data, test_root)
    analysis_data = analyzer.analyze

    refute analysis_data[:same]
    assert_equal 0, analysis_data[:not_in_master].count, 'not master count'
    assert_equal 0, analysis_data[:not_in_current].count, 'not current count'
    assert_equal 2, analysis_data[:changed_element_pairs].count, 'changed element pairs count'
    assert_equal 2, analysis_data[:changed_master].count, 'changed master count'
  end

end
