# README

Expected Ruby version: 2.4+

## Heroku

To set up in Heroku:

* Create project (Hobby or above)

* Add redis (background jobs)

* Add Sentry (Error handling)

* Push to heroku

* ```heroku run bundle exec rake db:migrate```

* Ensure there is at least 1 dyno each for web, worker and cron


## Scaling

Usually, 3 dynos in total will take you a long way. Sidekiq provides nice metrics.

The cron proccesses can be duplicated for high availability. They are not heavy weight in any way.

The heavy lifting is done in the Sidekiq workers. Check-ins and periodic analysis is done in Sidekiq.

The web worker handles user requests and check-ins. Make sure your users don't exhaust the web pool. Check-in requests are really quick,
as the post payload is stored in a sidekiq job. Authentication happend out of band.



## Tests

    bundle exec rspec



## License (MIT)

Copyright (c) 2017 Martin Neiiendam

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
