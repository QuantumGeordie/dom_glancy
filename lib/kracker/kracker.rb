module Kracker
  require 'yaml'

  def page_map_same?(test_root)
    purge_old_files_before_test(test_root)

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

    File.delete Kracker.current_filename(test_root) if result

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

    js = <<-JS
            var kracker = {

                treeUp: function() {
                    var treeWalker = document.createTreeWalker(
                        document.body,
                        NodeFilter.SHOW_ELEMENT,
                        { acceptNode: function(node) { return NodeFilter.FILTER_ACCEPT; } },
                        false
                    );

                    var nodeList = [];

                    while(treeWalker.nextNode()){
                        var cn = treeWalker.currentNode;
                        var node_details = {
                            "height"  : cn.clientHeight,
                            "width"   : cn.clientWidth,
                            "id"      : cn.id,
                            "tag"     : cn.tagName,
                            "class"   : cn.className,
                          //"html"    : cn.innerHTML,
                            "top"     : cn.offsetTop,
                            "left"    : cn.offsetLeft,
                            "visible" : kracker.isVisible(cn)
                        }
                        nodeList.push(node_details);
                    }

                    return(nodeList);
                },

                isVisible: function(elem) {
                    return elem.offsetWidth > 0 || elem.offsetHeight > 0;
                }
            };
            return kracker.treeUp();
    JS

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

  def purge_old_files_before_test(test_root)
    File.delete Kracker.current_filename(test_root) if File.exist?(Kracker.current_filename(test_root))

    filename_pattern = File.join(Kracker.diff_file_location, "#{test_root}__*__diff.yaml")
    Dir[filename_pattern].each { |file| file.delete(file) if File.exist?(file) }
  end
end
