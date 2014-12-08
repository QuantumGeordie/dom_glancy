module TestHelpers
  module Location
    def prep_locations_for_test
      @locations_root = File.expand_path('../../tmp', __FILE__)

      DomGlancy.configure do |config|
        config.master_file_location  = File.join(@locations_root, 'masters')
        config.current_file_location = File.join(@locations_root, 'current')
        config.diff_file_location    = File.join(@locations_root, 'diff')
      end

      FileUtils.mkdir_p(DomGlancy.configuration.master_file_location)
      FileUtils.mkdir_p(DomGlancy.configuration.diff_file_location)
      FileUtils.mkdir_p(DomGlancy.configuration.current_file_location)
    end

    def delete_test_locations
      FileUtils.rm_rf DomGlancy.configuration.master_file_location
      FileUtils.rm_rf DomGlancy.configuration.current_file_location
      FileUtils.rm_rf DomGlancy.configuration.diff_file_location
    end

    def delete_contents_from_dom_glancy_locations
      Dir[File.join(DomGlancy.configuration.master_file_location, '*.yaml')].each  { |file| FileUtils.rm_rf file }
      Dir[File.join(DomGlancy.configuration.current_file_location, '*.yaml')].each { |file| FileUtils.rm_rf file }
      Dir[File.join(DomGlancy.configuration.diff_file_location, '*.html')].each    { |file| FileUtils.rm_rf file }
      Dir[File.join(DomGlancy.configuration.diff_file_location, '*.yaml')].each    { |file| FileUtils.rm_rf file }
    end
  end
end
