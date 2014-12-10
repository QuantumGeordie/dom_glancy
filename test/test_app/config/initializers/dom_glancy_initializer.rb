DomGlancy.configure do |c|
  c.master_file_location  = Rails.root.join('tmp', 'data', 'map', 'masters')
  c.current_file_location = Rails.root.join('tmp', 'data', 'map', 'current')
  c.diff_file_location    = Rails.root.join('tmp', 'data', 'map', 'diff')
  c.similarity            = 15
end

FileUtils.mkdir_p(DomGlancy.configuration.master_file_location)
FileUtils.mkdir_p(DomGlancy.configuration.diff_file_location)
FileUtils.mkdir_p(DomGlancy.configuration.current_file_location)
