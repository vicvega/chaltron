class Log < ApplicationRecord
  SEVERITIES = %w[emerg alert crit err warning notice info debug].freeze

  validates_presence_of :severity, :message
  validates_inclusion_of :severity, in: SEVERITIES

  before_validation :standardize_severity, :truncate_message

  after_create :to_syslog if Chaltron.enable_syslog

  private

  def standardize_severity
    self.severity = :emerg   if severity&.to_sym == :panic
    self.severity = :err     if severity&.to_sym == :error
    self.severity = :warning if severity&.to_sym == :warn
  end

  def truncate_message
    self.message = message&.truncate(1000)
  end

  def to_syslog
    Syslog.open(Rails.application.class.parent.to_s, Syslog::LOG_PID, Chaltron.syslog_facility) do |s|
      s.send(self.severity.to_sym, self.category.upcase + ' - ' + self.message)
    end
  end
end
