class Admins::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token

    def after_sign_out_path_for(_resource_or_scope)
      new_admin_session_path
    end
  
    def after_sign_in_path_for(resource_or_scope)
puts 'here==================='
      stored_location_for(resource_or_scope) || root_path
    end
  end