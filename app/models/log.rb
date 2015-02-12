class Log < ActiveRecord::Base
  Severities = %w( info debug error )

  validates_presence_of :severity, :message
  validates_inclusion_of :severity, in: Severities

  after_create :to_syslog if Chaltron.enable_syslog

  private
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
