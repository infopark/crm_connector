require 'helpful_configuration'
require 'json'

def either_file(*files)
  found = files.detect do |file|
    File.exist?(file)
  end
  raise "Could not find any of the files #{files.join(', ')}" unless found
  found
end

def local_config
  config =
    if ENV['CRM_LOGIN'].present?
      HelpfulConfiguration.new({
        'url' => ENV['CRM_API_URL'],
        'login' => ENV['CRM_LOGIN'],
        'api_key' => ENV['CRM_API_KEY'],
      }.reject {|k,v| v.blank?}, "ENV")
    elsif ENV['TRAVIS_JOB_NUMBER'].present?
      tenant_number = ENV['TRAVIS_JOB_NUMBER'].split('.').last
      puts "Detected Travis build. Using Tenant ##{tenant_number}."
      HelpfulConfiguration.new({
        'url' => ENV["CRM_#{tenant_number}_API_URL"],
        'login' => ENV["CRM_#{tenant_number}_LOGIN"],
        'api_key' => ENV["CRM_#{tenant_number}_API_KEY"],
      }.reject {|k,v| v.blank?}, "Travis ENV")
    else
      local_config_file = either_file(
        Pathname(__FILE__).expand_path + "../config.json",
        Pathname(ENV['HOME']) + '.config/infopark/crm_connector.json'
      )
      HelpfulConfiguration.new(JSON.parse(File.read(local_config_file)), local_config_file)
    end

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
