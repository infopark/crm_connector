Gem::Specification.new do |s|
  s.name = 'infopark_crm_connector'
  s.version = begin
    `cd #{File.dirname(__FILE__)} && git describe`.chomp.gsub(/-([0-9]+)-g/) { ".#{$1}." }.tap do
      raise "git describe failed" unless $?.success?
    end
  end
  s.authors = ["Infopark AG"]
  s.description = 'Infopark CRM Connector'
  s.email = 'info@infopark.de'
  s.files = Dir["README.markdown", "CHANGELOG.markdown", "LICENSE", ".yardopts", "lib/**/*.rb"].sort
  s.homepage = 'http://www.infopark.de'
  s.summary = 'Infopark CRM Connector'
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.5")
  s.has_rdoc = 'yard'
  s.license = 'LGPL-3.0'

  s.add_dependency("activeresource", ">=3.1")
end
