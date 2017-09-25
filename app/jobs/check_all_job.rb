class CheckAllJob < ActiveJob::Base
  queue_as :default

  def perform()
    Canary.find_each do |canary|
      CheckCanaryJob.perform_later(canary.id)
    end
  end
end
