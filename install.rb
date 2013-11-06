# Install hook code here
puts "Installing files..."
`cd #{RAILS_ROOT}/vendor/plugins/acts_as_noteable && rake update_scripts && cd #{RAILS_ROOT}`
puts "Files Installed"