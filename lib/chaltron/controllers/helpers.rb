module Chaltron
  module Controllers
    # Those helpers are convenience methods added to ApplicationController.
    module Helpers
      extend ActiveSupport::Concern
      included do
        rescue_from ::CanCan::AccessDenied do |exception|
    	    redirect_to root_url, alert: current_user.nil? ? t(:access_denied_try_login) : t(:access_denied)
    	  end
      end
    end
  end
end
