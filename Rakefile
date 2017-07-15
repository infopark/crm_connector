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
  t.test_files = FileList['test/**/*_test.rb']
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

namespace :travis do
  desc "Encrypt ENV vars for travis."
  task :encrypt_keys do
    # Github token needs permissions "repo" and "user:email"
    # to authenticate with travis (see https://github.com/settings/tokens and
    # http://docs.travis-ci.com/api/#with-a-github-token )
    require "travis"
    require "io/console"
    secret_input = lambda do |prompt|
      print("#{prompt}: ")
      STDIN.noecho(&:gets).strip.tap { puts }
    end
    Travis.github_auth(secret_input.call("Github access token"))
    repo = Travis::Repository.find("infopark/crm_connector")
    msg = "Update the file .travis.yml manually:\n"
    %w[
      CRM_API_KEY
    ].each do |s|
      encr = repo.encrypt("#{s}=\"#{secret_input.call(s)}\"")
      msg << "  # #{s}:\n"
      msg << "  - secure: \"#{encr}\"\n"
    end
    puts(msg)
  end
end
