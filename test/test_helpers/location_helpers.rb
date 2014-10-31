module DomGlancy
  module TestHelpers
    module Location
      def prep_locations_for_test
        @locations_root = File.expand_path('../../tmp', __FILE__)

        DomGlancy.master_file_location  = File.join(@locations_root, 'masters')
        DomGlancy.current_file_location = File.join(@locations_root, 'current')
        DomGlancy.diff_file_location    = File.join(@locations_root, 'diff')

        DomGlancy.create_comparison_directories
      end

      def delete_test_locations
        FileUtils.rm_rf DomGlancy.master_file_location
        FileUtils.rm_rf DomGlancy.current_file_location
        FileUtils.rm_rf DomGlancy.diff_file_location
      end

      def delete_contents_from_dom_glancy_locations
        Dir[File.join(DomGlancy.master_file_location, "*.yaml")].each { |file| FileUtils.rm_rf file }
        Dir[File.join(DomGlancy.current_file_location, "*.yaml")].each { |file| FileUtils.rm_rf file }
        Dir[File.join(DomGlancy.diff_file_location, "*.html")].each { |file| FileUtils.rm_rf file }
        Dir[File.join(DomGlancy.diff_file_location, "*.yaml")].each { |file| FileUtils.rm_rf file }
      end
    end
  end
end
