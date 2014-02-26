module Kracker

  @master_file_location  = nil
  @diff_file_location    = nil
  @current_file_location = nil

  def self.master_file_location=(location)
    @master_file_location = location
  end

  def self.master_file_location
    @master_file_location
  end

  def self.diff_file_location=(location)
    @diff_file_location = location
  end

  def self.diff_file_location
    @diff_file_location
  end

  def self.current_file_location=(location)
    @current_file_location = location
  end

  def self.current_file_location
    @current_file_location
  end

  def self.create_comparison_directories
    ::FileUtils.mkdir_p(@master_file_location)
    ::FileUtils.mkdir_p(@diff_file_location)
    ::FileUtils.mkdir_p(@current_file_location)
  end

  def self.master_filename(test_root)
    File.join(self.master_file_location, "#{test_root}_master.yaml")
  end

  def self.current_filename(test_root)
    File.join(self.current_file_location, "#{test_root}.yaml")
  end

  def self.diff_filename(test_root)
    File.join(self.diff_file_location, "#{test_root}_diff.html")
  end

end