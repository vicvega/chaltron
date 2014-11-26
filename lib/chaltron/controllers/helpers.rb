module Chaltron
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern
      included do
        rescue_from ::CanCan::AccessDenied do |exception|
          alert = current_user.nil? ? t('chaltron.access_denied_try_login') : t('chaltron.access_denied')
    	    redirect_to root_url, alert: alert
    	  end
      end
    end
  end
end
