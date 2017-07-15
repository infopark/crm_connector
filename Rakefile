require "rubygems"
require "bundler/setup"
require 'rake/testtask'

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
end

Rake::TestTask.new do |t|
  t.libs << "test"
  # t.test_files = FileList.new(['test/**/*_test.rb']) do |f|
  #   f.exclude(/multitenancy|rails_form|host_aware/)
  # end
  t.test_files = FileList['test/**/*_test.rb']

  t.verbose = true
end

task :default => :test
task :travis => :test

gemspec = eval(File.read('infopark_crm_connector.gemspec'))

desc "Builds the gem"
task :gem do
  Gem::Builder.new(gemspec).build
end

desc "Installs the gem"
task :install => :gem do
  sh "gem install infopark_crm_connector-#{gemspec.version}.gem --no-rdoc --no-ri"
end
