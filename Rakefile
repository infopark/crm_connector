require 'appraisal'
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

gemspec = eval(File.read('infopark_crm_connector.gemspec'))

desc "Builds the gem"
task :gem do
  Gem::Builder.new(gemspec).build
end

desc "Installs the gem"
task :install => :gem do
  sh "gem install infopark_crm_connector-#{gemspec.version}.gem --no-rdoc --no-ri"
end


desc "Once in a while cleanup the CRM database content"
task :cleanup do
  require "./script/connector_initializer"
  t = 1.hour.ago.utc
  [Activity, EventContact, Event, Mailing, Contact, Account, Role].each do |klass|
    puts "Cleaning up #{klass}"
    i = 0
    klass.all(params: {limit: 1000}).each do |item|
      case item
      when Role
        next if item.name == "superuser"
      when Contact
        next if item.login == "root"
        next if Time.parse(item.updated_at) > t
      else
        next if Time.parse(item.updated_at) > t
      end
      item.destroy
      i += 1
    end
    puts "-> deleted #{i} items"
  end
end
