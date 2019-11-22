#!/bin/bash

# rake db:drop
# rake db:rollback

# rake db:migrate
# rake db:seed
# rake db:setup

#Load or setup the environment files!
source ~/.bashrc 

echo "THE SCRIPT TO RESTART THE DB IS RUNNING! ON: "
whoami

strdev="DEV"
strprod="PROD"
strtest="TEST"

if [ $1 == $strdev ]; then
    echo "- DEVELOPMENT DB IS SETTING UP!"
    # PostreSQL is not running previous migrations even before removing the schema so...
    rm db/schema.rb
    # Drop DB:
    rake db:drop RAILS_ENV=development 
    # Create all DBs: #rake db:create
    rails db:setup RAILS_ENV=development
    # Migrate DB:
    rake db:migrate RAILS_ENV=development
    # Seed DB:
    rake db:seed RAILS_ENV=development
    # If we are looking for independency between test and development db we should have
    # different folders because even though development enviroment is being specified 
    # the commands above performs the same actions on the test enviroment
else
  if [ $1 == $strprod ]; then
        echo "- PRODUCTION DB IS SETTING UP!"
        # PostreSQL is not running previous migrations even before removing the schema so...
        rm db/schema.rb
        # Drop the DB:
        rake db:drop RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1
        # Create DB: #rake db:create
        rails db:setup RAILS_ENV=production
        # Migrate DB:
        rake db:migrate RAILS_ENV=production
        # Seed DB:
        rake db:seed RAILS_ENV=production
  else
    if [ $1 == $strtest ]; then
        echo "- TEST ENV IS SETTING UP!"
        # PostreSQL is not running previous migrations even before removing the schema so...
        rm db/schema.rb
        # Drop DB:
        rake db:drop RAILS_ENV=test
        # Create DB: #rake db:create
        rake db:test:prepare
        rails db:setup RAILS_ENV=test
        # Migrate DB:
        rake db:migrate RAILS_ENV=test
        # Seed DB:
        rake db:seed RAILS_ENV=test
        # To SEED your test DB properly: rails c -e test THEN Rails.application.load_seed
    else
        echo "ERROR! INVALID ENVIRONMENT!"
    fi
  fi
fi
