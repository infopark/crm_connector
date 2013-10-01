buckets :test do
  # all in one bucket, because the tests use always the same crm tenant.
  bucket(:unit_test).performs_rake_tasks(%w(
    appraisal:install
    appraisal:activeresource_3.2
    appraisal:activeresource_3.1
    appraisal:activeresource_3.0
  ))
end
