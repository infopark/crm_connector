activeresource_versions = %w|3.1 3.2|

activeresource_versions.each do |version|
  appraise "activeresource_#{version}" do
    gem "activeresource", "~>#{version}.0"
  end
end
