module Kracker
  require 'yaml'

  def page_map_same?(test_root)
    result, msg = master_file_exists?(test_root)

    return [result, msg] unless result

    result, msg = map_current_file(test_root)

    return [result, msg]  unless result

    result, msg, current_data = read_map_file(Kracker.current_filename(test_root))
    return [result, msg]  unless result

    result, msg, master_data = read_map_file(Kracker.master_filename(test_root))
    return [result, msg]  unless result

    result, msg = analyze_map_differences(master_data, current_data)

  end

  def analyze_map_differences(master_data, current_data)
    analysis = analyze(master_data, current_data)
    msg = make_analysis_failure_report(analysis)
    [analysis[:same], msg]
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
    [ {} ]
  end

  def master_file_exists?(test_root)
    filename = Kracker.master_filename(test_root)
    result = File.exist?(filename)
    msg = result ? '' : "Master file does not exist: #{filename}"
    [result, msg]
  end

end
