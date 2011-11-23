task :default => :help

desc "Description of the Sort and Display"
task :help do
  puts "Cyrus Code Exercise Instruction:"
  puts "rake FIELD='gender' FLAG='desc' display will show order result"
  puts "FIELD can be gender first_name last_name favor_color date_of_birth"
  puts "FLAG can be desc or asc"
  puts "rake -T will list the tasks"
  puts "enjoy."
end

desc "run unit test"
task :test do
  ruby 'sort_display_test.rb'
end

desc "show sorting result"
task :display do
  field = ENV['FIELD'] || 'date_of_birth'
  flag = ENV['FLAG'] || 'asc'
  require_relative 'sort_display'
  Rake::Task[:generate].invoke
  records = SortDisplay.load_from_file
  rs = SortDisplay.sort_by records, field, flag
  puts "Currently show sort records by #{field} #{flag}"
  puts "OutPut:"
  rs.each{|x|puts x.str}
  Rake::Task[:clean].invoke
end

desc "generate file needed to load and sort"
task :generate do
  require_relative 'sort_display'
  SortDisplay.generate_to_file
end

desc "clean temp file generate by the test or the project"
task :clean do
  require 'rake/clean'
  CLEAN.include('*.rd')
end
