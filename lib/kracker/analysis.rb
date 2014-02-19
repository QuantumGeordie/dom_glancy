module Kracker

  def analyze(master_data, current_data)
    output_hash = {}

    master_set  = master_data.to_set
    current_set = current_data.to_set

    set_current_not_master = current_set - master_set
    set_master_not_current = master_set  - current_set

    changed_element_pairs = []
    if set_master_not_current.count > 0 || set_current_not_master.count > 0
      changed_element_pairs = get_set_of_same_but_different(set_current_not_master, set_master_not_current)

      changed_element_pairs.each do |item1, item2|
        set_current_not_master.delete(item1)
        set_current_not_master.delete(item2)

        set_master_not_current.delete(item1)
        set_master_not_current.delete(item2)
      end

      changed_element_pairs.select!{ |pair| !DOMElement.new(pair[0]).close_enough?(DOMElement.new(pair[1])) }
    end

    output_hash[:not_in_master]  = set_current_not_master
    output_hash[:not_in_current] = set_master_not_current
    output_hash[:changed_element_pairs] = changed_element_pairs
    output_hash[:same] = set_current_not_master.count == 0 && set_master_not_current.count == 0 && changed_element_pairs.count == 0

    output_hash
  end

  def get_set_of_same_but_different(set1, set2)
    same_but_different_pairs = []
    set1.each do |item1|
      element1 = DOMElement.new(item1)
      set2.each do |item2|
        element2 = DOMElement.new(item2)
        if element1.same_element?(element2)
          same_but_different_pairs << [item1, item2] #unless element1.close_enough?(element2)
        end
      end
    end
    same_but_different_pairs
  end

  def make_analysis_failure_report(analysis_data)
    return '' if analysis_data[:same]

    msg =  "\nMap Failure:\n"
    msg += "\tElements not in master: #{analysis_data[:not_in_master].count}\n"
    msg += "\tElements not in current: #{analysis_data[:not_in_current].count}\n"
    msg += "\tChanged elements: #{analysis_data[:changed_element_pairs].count}\n"
  end


end