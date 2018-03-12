class Log < ActiveRecord::Base
  Severities = %w( emerg panic alert crit err warning notice info debug )

  validates_presence_of :severity, :message
  validates_inclusion_of :severity, in: Severities

  before_validation :change_severity

  after_create :to_syslog if Chaltron.enable_syslog

  private

  def change_severity
    self.severity = :err if self.severity && self.severity.to_sym == :error
    self.severity = :warning if self.severity && self.severity.to_sym == :warn
  end

  def to_syslog
    syslog_method =
      case self.severity
      when 'info' then :notice
      when 'debug' then :debug
      when 'error' then :err
      else :info
    end
    Syslog.open(Rails.application.class.parent.to_s, Syslog::LOG_PID, Chaltron.syslog_facility) do |s|
      s.send(syslog_method, self.category.upcase + ' - ' + self.message)
    end
  end

end
