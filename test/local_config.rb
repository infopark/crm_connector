require 'helpful_configuration'
require 'json'

def either_file(*files)
  found = files.detect do |file|
    File.exists?(file)
  end
  raise "Could not find any of the files #{files.join(', ')}" unless found
  found
end

def local_config
  local_config_file = either_file(
    Pathname(__FILE__).expand_path + "../config.json",
    Pathname(ENV['HOME']) + '.config/infopark/crm_connector.json'
  )
  config = HelpfulConfiguration.new(JSON.parse(File.read(local_config_file)), local_config_file)
  config.explain(
    "url",
    "the url of the webcrm tenant"
  )
  config.explain(
    "login",
    "The webservice login"
  )
  config.explain(
    "api_key",
    "The webservice api key"
  )
  config
end
