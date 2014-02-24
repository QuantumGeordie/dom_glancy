watch( './*\.rb' ) do |md|
  system("clear && rake test:units")
end