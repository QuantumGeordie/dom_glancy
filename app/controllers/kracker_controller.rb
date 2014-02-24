class KrackerController < KrackerApplicationController
  def index
    @files = if Kracker.diff_file_location
               Dir[File.join(Kracker.diff_file_location, "*_diff.yaml")]
    else
      []
    end
  end

  def path_config
  end

  def new
  end

  def artifacts
  end

  def about
  end
end
