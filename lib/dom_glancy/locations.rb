module DomGlancy
  class DomGlancy

    def self.create_comparison_directories
      FileUtils.mkdir_p(::DomGlancy.configuration.master_file_location)
      FileUtils.mkdir_p(::DomGlancy.configuration.diff_file_location)
      FileUtils.mkdir_p(::DomGlancy.configuration.current_file_location)
    end

    def self.master_filename(test_root)
      File.join(::DomGlancy.configuration.master_file_location, "#{test_root}_master.yaml")
    end

    def self.current_filename(test_root)
      File.join(::DomGlancy.configuration.current_file_location, "#{test_root}.yaml")
    end

    def self.diff_filename(test_root)
      File.join(::DomGlancy.configuration.diff_file_location, "#{test_root}_diff.html")
    end
  end
end
