module DomGlancy
  class FileNameBuilder
    attr_accessor :test_root

    def initialize(test_root = '')
      @test_root = test_root
    end

    def master
      File.join(::DomGlancy.configuration.master_file_location, "#{@test_root}_master.yaml")
    end

    def current
      File.join(::DomGlancy.configuration.current_file_location, "#{@test_root}.yaml")
    end

    def diff
      File.join(::DomGlancy.configuration.diff_file_location, "#{@test_root}_diff.html")
    end
  end
end
