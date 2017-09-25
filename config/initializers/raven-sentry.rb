if ENV.key?('SENTRY_DSN')
  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']
    config.ssl_verification = false
    config.async = lambda { |event|
      SentryJob.perform_later(event.to_hash)
    }
  end
end
