require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'Infopark CRM Connector'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc', 'CHANGELOG.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.main = "README.rdoc"
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList.new(['test/**/*_test.rb']) do |f|
    f.exclude(/multitenancy|rails_form|host_aware/)
  end
#  t.test_files = FileList['test/**/*template*test.rb']

  t.verbose = true
end

task :default => :test
