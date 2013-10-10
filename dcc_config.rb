buckets :test do
  before_each_bucket.performs_rake_tasks('appraisal:install')
  bucket(:cleanup).performs_rake_tasks('cleanup')
  bucket(:integration_test_active_resource_3_1).performs_rake_tasks('appraisal:activeresource_3.1')
  bucket(:integration_test_active_resource_3_2).performs_rake_tasks('appraisal:activeresource_3.2')
end
