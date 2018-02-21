#!/bin/bash

#if [ "$RAILS_ENV" = "production" ]; then
#    if [ -f "config/database.yml" ]; then
        #rm config/database.yml
#    fi
#fi

bundle exec rake db:migrate

exec supervisord -c /app/config/supervisord.conf
