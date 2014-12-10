module DomGlancy
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :master_file_location
    attr_accessor :diff_file_location
    attr_accessor :current_file_location
    attr_accessor :similarity

    def initialize
      @master_file_location  = nil
      @diff_file_location    = nil
      @current_file_location = nil
      @similarity            = 15
    end
  end
end
