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

  def xtest_similar_pairs
    test_root = 'suso'
    file_1 = File.expand_path('../../test_objects/options_file_1.yaml', __FILE__)
    file_2 = File.expand_path('../../test_objects/options_file_2.yaml', __FILE__)
    file_1a = File.expand_path('../../test_objects/results_1.yaml', __FILE__)
    file_2a = File.expand_path('../../test_objects/results_2.yaml', __FILE__)

    result, msg, current_data = DomGlancy::MapFile.new.read(file_1)
    result, msg, master_data  = DomGlancy::MapFile.new.read(file_2)

    analyzer = ::DomGlancy::Analyzer.new(master_data, current_data, test_root)

    analyzer.send(:clear_results)
    similar_pairs = analyzer.send(:similar_pairs, analyzer.set_current_not_master, analyzer.set_master_not_current)

    puts "current not master: #{analyzer.set_current_not_master.count}"
    puts "master not current: #{analyzer.set_master_not_current.count}"
    puts "similar pairs:      #{similar_pairs.count}"

    hist = {}
    hist2 = {}
    similar_pairs.each do |pair|
      hist[pair[0].to_s] = hist[pair[0].to_s].to_i + 1
      hist2[pair[1].to_s] = hist2[pair[1].to_s].to_i + 1
    end

    puts hist.keys.count
    puts hist2.keys.count

    analyzer.send(:remove_elements_from_data_sets, similar_pairs)
    similar_pairs = analyzer.send(:similar_pairs, analyzer.set_current_not_master, analyzer.set_master_not_current)

    puts "current not master: #{analyzer.set_current_not_master.count}"
    puts "master not current: #{analyzer.set_master_not_current.count}"
    puts "similar pairs:      #{similar_pairs.count}"

    File.open(file_1a, 'w') { |f| f.write(analyzer.set_current_not_master.to_yaml) }
    File.open(file_2a, 'w') { |f| f.write(analyzer.set_master_not_current.to_yaml) }
  end

  def xtest_from_similar_files
    test_root = 'jordan_henderson'
    file_1 = File.expand_path('../../test_objects/options_file_1.yaml', __FILE__)
    file_2 = File.expand_path('../../test_objects/options_file_2.yaml', __FILE__)

    result, msg, current_data = DomGlancy::MapFile.new.read(file_1)
    assert result
    result, msg, master_data  = DomGlancy::MapFile.new.read(file_2)
    assert result

    analyzer = ::DomGlancy::Analyzer.new(master_data, current_data, test_root)
    analysis_data = analyzer.analyze

    puts "not in master:  #{analysis_data[:not_in_master].count}"
    puts "not in current: #{analysis_data[:not_in_current].count}"
    puts "changed pairs:  #{analysis_data[:changed_element_pairs].count}"
    puts "changed master: #{analysis_data[:changed_master].count}"

    assert analysis_data[:same]

  end

end
