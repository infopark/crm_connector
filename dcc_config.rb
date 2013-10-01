buckets :test do
  before_each_bucket.performs_rake_tasks('appraisal:install')
  bucket(:unit_test_active_resource_3_0).performs_rake_tasks('appraisal:activeresource_3.0')
  bucket(:unit_test_active_resource_3_1).performs_rake_tasks('appraisal:activeresource_3.1')
  bucket(:unit_test_active_resource_3_2).performs_rake_tasks('appraisal:activeresource_3.2')
end
