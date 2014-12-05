class DomGlancyController < DomGlancyApplicationController
  layout 'dom_glancy'

  require 'kramdown'

  def index
    @files = if DomGlancy::DomGlancy.diff_file_location
      Dir[File.join(DomGlancy::DomGlancy.diff_file_location, "*_diff.html")].map{|f| File.basename(f)}
    else
      []
    end
  end

  def show
    @test_root = params[:diff_file].gsub('_diff', '').gsub('.html', '')

    @file_diff            = "#{@test_root}_diff.html"
    @file_set_not_master  = "#{@test_root}__current_not_master__diff.yaml"
    @file_set_not_current = "#{@test_root}__master_not_current__diff.yaml"
    @file_set_changed     = "#{@test_root}__changed_master__diff.yaml"

    @file_diff = "#{@test_root}_diff.html"
  end

  def path_config
  end

  def new
    @files_current = Dir[File.join(DomGlancy::DomGlancy.current_file_location, '*.yaml')].map { |f| File.basename(f).gsub('.yaml', '') }
    @files_master  = Dir[File.join(DomGlancy::DomGlancy.master_file_location,  '*.yaml')].map { |f| File.basename(f).gsub('.yaml', '') }

    @extra_files = @files_current.select { |f| !@files_master.include?("#{f}_master")}.sort
  end

  def make_master
    test_root = params[:file]
    src = DomGlancy::DomGlancy.current_filename(test_root)
    dst = DomGlancy::DomGlancy.master_filename(test_root)
    FileUtils.cp src, dst

    redirect_to '/dom_glancy/new'
  end

  def delete_current
    test_root = params[:file]
    src = DomGlancy::DomGlancy.current_filename(test_root)
    FileUtils.rm_rf src

    redirect_to '/dom_glancy/new'
  end

  def artifacts
    artifacts_location = File.expand_path(File.join('~', 'Downloads', '*_artifacts.zip'))
    @artifacts = Dir.glob(artifacts_location).map { |f| File.basename(f) }
  end

  def artifacts_delete
    artifacts = params[:file].gsub('^', '.')
    FileUtils.rm_rf File.expand_path(File.join('~', 'Downloads', artifacts))
    redirect_to '/dom_glancy/artifacts'
  end

  def artifacts_expand
    artifacts = params[:file].gsub('^', '.')
    artifacts = File.expand_path(File.join('~', 'Downloads', artifacts))

    Zip::ZipFile.open(artifacts) do |zip_file|
      zip_file.each do |entry|
        file_destination = generate_unzip_destination(entry.name)
        File.open(file_destination, 'wb') { |file| file.write(zip_file.read(entry)) } if file_destination
      end
    end

    redirect_to dom_glancy_path
  end

  def about
    about_file = File.expand_path('../../../README.md', __FILE__)
    raw = File.read(about_file)
    @about = Kramdown::Document.new(raw).to_html
  end

  def clear
    Dir[File.join(DomGlancy::DomGlancy.diff_file_location, '*.yaml'), File.join(DomGlancy::DomGlancy.diff_file_location, '*.html')].each { |f| FileUtils.rm_rf(f) }
    Dir[File.join(DomGlancy::DomGlancy.current_file_location, '*.yaml')].each { |f| FileUtils.rm_rf(f) }
    redirect_to dom_glancy_path
  end

  def bless
    blessings = []
    params.each_pair { |k, v| blessings << v if k.start_with?('option_') }

    blessings.each do |blessing|
      base_test_name = blessing

      src_yaml = DomGlancy::DomGlancy.current_filename(base_test_name)
      dst_yaml = DomGlancy::DomGlancy.master_filename(base_test_name)

      FileUtils.cp src_yaml, dst_yaml if File.exist?(src_yaml)

      if params['delete_on_bless'] == 'true'
        files_to_remove  = [DomGlancy::DomGlancy.diff_filename(base_test_name)]
        files_to_remove << File.join(DomGlancy::DomGlancy.diff_file_location, blessing + '__current_not_master__diff.yaml')
        files_to_remove << File.join(DomGlancy::DomGlancy.diff_file_location, blessing + '__master_not_current__diff.yaml')
        files_to_remove << File.join(DomGlancy::DomGlancy.diff_file_location, blessing + '__changed_master__diff.yaml')

        files_to_remove.each { |f| FileUtils.rm_rf f }
      end
    end

    redirect_to dom_glancy_path
  end

end
