class KrackerController < KrackerApplicationController
  def index
    @master_file_location = Kracker.master_file_location
  end
end
