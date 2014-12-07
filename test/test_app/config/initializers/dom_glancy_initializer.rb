DomGlancy.configure do |c|
  c.master_file_location  = Rails.root.join('tmp', 'data', 'map', 'masters')
  c.current_file_location = Rails.root.join('tmp', 'data', 'map', 'current')
  c.diff_file_location    = Rails.root.join('tmp', 'data', 'map', 'diff')
end

DomGlancy::DomGlancy.create_comparison_directories
