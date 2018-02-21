require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  clock_id = SecureRandom.uuid


  def self.redis
    @redis ||= Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost', password: ENV['REDIS_PASSWORD'])
  end

  def self.is_master?(clock_id)
    redis.ttl('clockwork') > 0 && redis.get('clockwork') == clock_id
  end

  def self.master_present?(clock_id)
    redis.ttl('clockwork') > 0 && redis.get('clockwork') != clock_id
  end

  def self.take_master(clock_id)
    redis.setnx('clockwork', clock_id)
    redis.expire('clockwork', 11)
  end

  def self.elect_master(clock_id)
    return if master_present?(clock_id)
    take_master(clock_id)
  end

  def self.schedule_check(clock_id)
    if is_master?(clock_id)
      CheckAllJob.perform_later
    end
  end

  handler do |job|
    case job
    when 'elect_master'
      elect_master(clock_id)
    when 'schedule_check'
      schedule_check(clock_id)
    end
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end

  every(10.seconds, 'elect_master')
  every(1.minute, 'schedule_check')

end
