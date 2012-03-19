# Get started

    git clone git@github.com:infopark/omc_connector.git
    cd omc_connector/

    git checkout webcrm

    git submodule update --init
    bundle

# Run tests

    # Configure test/test_config.rb with an empty WebCRM Tenant
    bundle exec rake test


Test all supported versions:

    bundle exec rake appraisal:install
    bundle exec rake appraisal

# Build and install gem

    gem build infopark_crm_connector.gemspec
    gem install infopark_crm_connector-*.gem

# Documentation

    bundle exec rake rdoc
    open rdoc/index.html
