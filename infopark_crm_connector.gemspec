require File.expand_path('../rake_support/git_based_version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'infopark_crm_connector'
  s.version = RakeSupport.git_based_version(__FILE__)
  s.authors = ["Infopark AG"]
  s.description = 'Infopark CRM Connector'
  s.email = 'info@infopark.de'
  s.files = Dir["README.rdoc", "CHANGELOG.rdoc", "LICENSE", "lib/**/*.rb"].sort
  s.homepage = 'http://www.infopark.de'
  s.rdoc_options = [
    '--charset', 'UTF-8',
    '--main', 'README.rdoc',
    '--title', "Infopark CRM Connector #{s.version} Documentation", # CRAP! gem knows better than we do?!?
  ]
  s.summary = 'Infopark CRM Connector'
  s.extra_rdoc_files = Dir["README.rdoc", "LICENSE"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5")
  s.has_rdoc = true

  s.add_dependency("activeresource", ">=3")
  s.add_dependency("backports", ">=2.3") #support ruby 1.9 features in ruby 1.8
  s.add_dependency("logger")
end
