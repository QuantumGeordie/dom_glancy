require "kracker/version"
require 'kracker/element'

module Kracker

  def analyze_data_sets(master_data, current_data)
    output_hash = {}

    master_set  = master_data.to_set
    current_set = current_data.to_set

    set_current_not_master = current_set - master_set
    set_master_not_current = master_set  - current_set

    output_hash[:not_in_master]  = set_current_not_master
    output_hash[:not_in_current] = set_master_not_current

    output_hash
  end

end
