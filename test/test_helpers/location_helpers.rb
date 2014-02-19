module Kracker
  module TestHelpers
    module Location

      def prep_locations_for_test
        @locations_root = File.expand_path('../../tmp', __FILE__)

        Kracker.master_file_location  = File.join(@locations_root, 'masters')
        Kracker.current_file_location = File.join(@locations_root, 'current')
        Kracker.diff_file_location    = File.join(@locations_root, 'diff')

        Kracker.create_comparison_directories
      end

      def delete_test_locations
        FileUtils.rm_rf Kracker.master_file_location
        FileUtils.rm_rf Kracker.current_file_location
        FileUtils.rm_rf Kracker.diff_file_location
      end
    end
  end
end
