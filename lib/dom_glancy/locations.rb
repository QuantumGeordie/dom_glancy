module DomGlancy
  class DomGlancy
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
