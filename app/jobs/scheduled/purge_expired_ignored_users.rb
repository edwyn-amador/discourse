# frozen_string_literal: true

module Jobs
  class PurgeExpiredIgnoredUsers < ::Jobs::Scheduled
    every 1.day

    def execute(args)
      IgnoredUser.where("expiring_at <= ?", Time.zone.now).delete_all
      IgnoredUser.where("created_at <= ? AND expiring_at IS NULL", 4.months.ago).delete_all
    end
  end
end
