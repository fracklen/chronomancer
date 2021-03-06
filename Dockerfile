FROM ruby:2.4
MAINTAINER Martin Neiiendam <fracklen@gmail.com>
# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN useradd -ms /bin/bash app && \
  apt-get update && apt-get install -y \
  build-essential \
  supervisor \
  nodejs

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
COPY gems ./gems
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

# Copy the main application.
COPY . ./
ENV RAILS_ENV production
RUN DATABASE_URL=postgresql://127.0.0.1:5432/foo bundle exec rake assets:precompile
RUN mkdir -p /app/log && chown -R app /app
USER app
# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["./scripts/run.sh"]
