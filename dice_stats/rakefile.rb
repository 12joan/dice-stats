require 'rspec/core/rake_task'
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
  task :test => :spec
end
