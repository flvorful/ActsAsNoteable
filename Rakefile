require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'fileutils'

desc 'Default: run unit tests.'
task :default => :test


desc 'Generate documentation for the acs_as_noteable plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Acts As Noteable'
  rdoc.options << '--line-numbers' << '--inline-source' << '--accessor=cattr_accessor'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Copies note_controller.rb to app/controllers and copies _note.rhtml to app/view/notes (it creates the folder if necessary).'
task :update_scripts do
	FileUtils.cp 'lib/notes_controller.rb', '../../../app/controllers'
	FileUtils.mkdir_p '../../../app/views/notes'
  FileUtils.cp 'lib/_note.rhtml', '../../../app/views/notes'
	FileUtils.cp 'lib/notes.css', '../../../public/stylesheets'	
end

desc 'Removes the "notes" files for the plugin.'
task :remove_scripts do
  FileUtils.rm '../../../app/controllers/notes_controller.rb'
  FileUtils.rm '../../../app/views/note/_note.rhtml'
	FileUtils.rm '../../../public/stylesheets/notes.css'	
end