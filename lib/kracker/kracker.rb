module Kracker
  require 'yaml'

  def page_map_same?(test_root)

    result, msg = map_current_file(test_root)
    return [result, msg]  unless result

    result, msg = master_file_exists?(test_root)
    return [result, msg] unless result

    result, msg, current_data = read_map_file(Kracker.current_filename(test_root))
    return [result, msg]  unless result

    result, msg, master_data = read_map_file(Kracker.master_filename(test_root))
    return [result, msg]  unless result

    analysis_data = analyze(master_data, current_data, test_root)

    msg = make_analysis_failure_report(analysis_data)
    result = analysis_data[:same]

    [result, msg]
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

  def map_current_file(test_root)
    filename = Kracker.current_filename(test_root)

    result = [true, '']
    begin
      data = perform_mapping_operation.to_yaml
      File.open(filename, 'w') { |file| file.write(data) }
    rescue Exception => e
      result = [false, "map current file error: #{e.message}"]
    end

    result
  end

  def perform_mapping_operation
    js = "return kracker.treeUp();"
    page.driver.browser.execute_script(js)
  end

  def master_file_exists?(test_root)
    filename = Kracker.master_filename(test_root)
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

end
