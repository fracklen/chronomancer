class Canary < ApplicationRecord
  belongs_to :team
  belongs_to :created_by, class_name: 'User'
  has_many :checkins
  belongs_to :alert_integration, optional: true
  has_many :alerts

  validates_uniqueness_of :name, scope: :team
  validates_uniqueness_of :uuid

  SCHEDULES = %w(
   EVERY_15_MINUTES
   EVERY_HOUR
   EVERY_3_HOURS
   EVERY_DAY
   EVERY_WEEK
   EVERY_MONTH
  )

  validates_inclusion_of :schedule, in: SCHEDULES

  def url(request)
    request.base_url + "/checkin/#{team.id}/#{self.uuid}"
  end

  def update_expected_checkin(timestamp)
    self.last_checkin = timestamp
    case self.schedule
    when 'EVERY_15_MINUTES'
      self.next_checkin = timestamp + 17.minutes
    when 'EVERY_HOUR'
      self.next_checkin = timestamp + 65.minutes
    when 'EVERY_3_HOURS'
      self.next_checkin = timestamp + 190.minutes
    when 'EVERY_DAY'
      self.next_checkin = timestamp + 25.hours
    when 'EVERY_WEEK'
      self.next_checkin = timestamp + 8.days
    when 'EVERY_MONTH'
      self.next_checkin = timestamp + 32.days
    else
      raise "Unknown schedule #{self.schedule}"
    end
    self.save
  end

  def silence
    case self.schedule
    when 'EVERY_15_MINUTES'
      1.hour
    when 'EVERY_HOUR'
      3.hours
    when 'EVERY_3_HOURS'
      1.day
    when 'EVERY_DAY'
      3.days
    when 'EVERY_WEEK'
      8.days
    when 'EVERY_MONTH'
      32.days
    else
      raise "Unknown schedule #{self.schedule}"
    end
  end

  def overdue?
    return true if self.next_checkin.nil?
    self.next_checkin < Time.zone.now
  end
end
