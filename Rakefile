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
  klasses = [
    Activity,
    Account,
    Contact,
    CustomType,
    Event,
    EventContact,
    Mailing,
    Role,
  ]
  klasses.each do |klass|
    puts "Cleaning up #{klass}"
    i = 0
    klass.all(:params => {:limit => 1000}).each do |item|
      case item
      when CustomType
        next if [
          "account",
          "base-event",
          "contact",
          "note",
          "support-case",
        ].include?(item.name)
        if item.name =~ /[_-](\d{14}Z?)$/
          begin
            next if Time.parse($1) > t
          rescue ArgumentError
            # name contains no timestamp yet
          end
        end
      when Role
        next if item.name == "superuser"
        if item.name =~ /[_-](\d{14}Z?)$/
          begin
            next if Time.parse($1) > t
          rescue ArgumentError
            # name contains no timestamp yet
          end
        end
      when Contact
        next if item.login == "root"
        next if Time.parse(item.updated_at) > t
      else
        next if Time.parse(item.updated_at) > t
      end
      begin
        item.destroy
        $stdout.write "."
        $stdout.flush
        i += 1
      rescue
        # concurrent cleanup conflict
        $stdout.write " "
        $stdout.flush
      end
    end
    puts "\n-> deleted #{i} items"
  end
end
