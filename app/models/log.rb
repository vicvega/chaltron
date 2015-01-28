class Log < ActiveRecord::Base
  validates_presence_of :severity, :message

#  after_create :to_syslog

#  private
#  def to_syslog
#    Syslog.open(Rails.application.class.parent.to_s, Syslog::LOG_PID, Chaltron.syslog_facility) do |s|
#      s.info self.category.upcase + ' - ' + self.message
#    end if Chaltron.enable_syslog
#  end

end
