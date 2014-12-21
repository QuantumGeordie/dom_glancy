module DomGlancy
  class MapFile
    def read(filename)
      results = [true, '', nil]
      begin
        results[2] = YAML::load( File.open( filename ) )
      rescue Exception => e
        results = [false, "Error reading data from file: #{filename}", nil]
      end

      results
    end
  end
end
