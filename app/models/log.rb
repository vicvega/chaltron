class Log < ActiveRecord::Base
  Severities = %w( info debug error )

  validates_presence_of :severity, :message
  validates_inclusion_of :severity, in: Severities

#  after_create :to_syslog

#  private
#  def to_syslog
#    Syslog.open(Rails.application.class.parent.to_s, Syslog::LOG_PID, Chaltron.syslog_facility) do |s|
#      s.info self.category.upcase + ' - ' + self.message
#    end if Chaltron.enable_syslog
#  end

end
