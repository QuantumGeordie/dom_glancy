require 'test_helper'

class AnalysisReporterTest < DomGlancyTestCase

  def test_analysis_reporter
    prep_locations_for_test

    test_root = 'kolo_torre'
    master_data = array_of_elements
    current_data = array_of_elements
    current_data << single_element_hash
    analyzer = DomGlancy::Analyzer.new(master_data, current_data, test_root)
    analyzer.send(:clear_results)

    reporter = DomGlancy::AnalysisReporter.new(test_root, analyzer.set_current_not_master, analyzer.set_master_not_current, analyzer.set_changed_master, analyzer.changed_element_pairs)

    reporter.create_diff_file

    files = Dir[File.join(DomGlancy.configuration.diff_file_location, '*')]

    assert_equal 5, files.length
    assert_includes files, File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_master__diff.yaml")
    assert_includes files, File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__current_not_master__diff.yaml")
    assert_includes files, File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__master_not_current__diff.yaml")
    assert_includes files, File.join(DomGlancy.configuration.diff_file_location, "#{test_root}__changed_pairs__diff.yaml")
    assert_includes files, File.join(DomGlancy.configuration.diff_file_location, "#{test_root}_diff.html")
  end
end
