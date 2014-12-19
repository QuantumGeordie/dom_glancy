module DomGlancy
  class DomGlancy
    def page_map_same?(test_root)
      purge_old_files_before_test(test_root)

      result, msg = ::DomGlancy::PageMapper.new.run(test_root)
      return [result, msg]  unless result

      result, msg = master_file_exists?(test_root)
      return [result, msg] unless result

      result, msg, current_data = read_map_file(::DomGlancy::FileNameBuilder.new(test_root).current)
      return [result, msg]  unless result

      result, msg, master_data = read_map_file(::DomGlancy::FileNameBuilder.new(test_root).master)
      return [result, msg]  unless result

      analysis_data = ::DomGlancy::Analyzer.new(master_data, current_data, test_root).analyze

      msg = make_analysis_failure_report(analysis_data)
      result = analysis_data[:same]

      File.delete ::DomGlancy::FileNameBuilder.new(test_root).current if result

      [result, msg]
    end

    private

    def make_analysis_failure_report(analysis_data)
      return '' if analysis_data[:same]

      fnb = ::DomGlancy::FileNameBuilder.new(analysis_data[:test_root])

      msg = ["\n------- DOM Comparison Failure ------"]
      msg << "Elements not in master: #{analysis_data[:not_in_master].count}"
      msg << "Elements not in current: #{analysis_data[:not_in_current].count}"
      msg << "Changed elements: #{analysis_data[:changed_element_pairs].count}"
      msg << "Files:"
      msg << "\tcurrent: #{fnb.current}"
      msg << "\tmaster: #{fnb.master}"
      msg << "\tdifference: #{fnb.diff}"
      msg << "Bless this current data set:"
      msg << "\t#{blessing_copy_string(analysis_data[:test_root])}"
      msg<< "-------------------------------------"

      msg.join("\n")
    end

    def blessing_copy_string(test_root)
      fnb = ::DomGlancy::FileNameBuilder.new(test_root)
      "cp #{fnb.current} #{fnb.master}"
    end

    def read_map_file(filename)
      results = [true, '', nil]
      begin
        results[2] = YAML::load( File.open( filename ) )
      rescue Exception => e
        results = [false, "Error reading data from file: #{filename}", nil]
      end

      results
    end

    def master_file_exists?(test_root)
      filename = ::DomGlancy::FileNameBuilder.new(test_root).master
      result = File.exist?(filename)
      msg = result ? '' : make_missing_master_failure_report(test_root)
      [result, msg]
    end

    def make_missing_master_failure_report(test_root)
      msg = ["\n------- DOM Comparison Failure ------"]
      msg << "Master file does not exist. To make a new master from"
      msg << "the current page, use this command:"
      msg << "\t#{blessing_copy_string(test_root)}"
      msg<< "-------------------------------------"

      msg.join("\n")
    end

    def purge_old_files_before_test(test_root)
      old_current_file = ::DomGlancy::FileNameBuilder.new(test_root).current
      File.delete old_current_file if File.exist?(old_current_file)

      filename_pattern = File.join(::DomGlancy.configuration.diff_file_location, "#{test_root}__*__diff.yaml")
      Dir[filename_pattern].each { |file| file.delete(file) if File.exist?(file) }
    end
  end
end
