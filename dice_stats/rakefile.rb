require 'rspec/core/rake_task'
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
  task :test => :spec
end

task :console do 
  ruby File.join("src", "console.rb")
end

task :server do 
  ruby File.join("src", "server.rb")
end

task :fill_cache do
  ruby File.join("src", "cache_filler.rb")
end

task :create_db do
  sh 'mkdir -p db/'
  sh 'sqlite3 -batch db/cache.db "create table caches (id varchar, results varchar)"'
end
