class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token

    def google_oauth2
      admin = Admin.from_google(from_google_params)
  
      if admin.present?
        sign_out_all_scopes
        access_token = request.env["omniauth.auth"]
          
        # Access_token is used to authenticate request made from the rails application to the google server
        admin.google_token = access_token.credentials.token
        # Refresh_token to request new access_token
        # Note: Refresh_token is only sent once during the first request
        refresh_token = access_token.credentials.refresh_token
        admin.google_refresh_token = refresh_token if refresh_token.present?
        admin.save
        
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect admin, event: :authentication
      else
        flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
        redirect_to new_admin_session_path
      end
    end
    
    def apple
      abort(params)
      admin = Admin.from_google(from_google_params)
      puts admin.to_json
      puts from_google_params.to_json


    abort('apple callback url')
    end

    protected
  
    def after_omniauth_failure_path_for(_scope)
      new_admin_session_path
    end
  
    def after_sign_in_path_for(resource_or_scope)
      # redirect_to new_admin_profile_path(resource_or_scope.id)
      puts 'here===============================================okay'
      puts resource_or_scope.to_json
      stored_location_for(resource_or_scope) || admin_calenders_path(resource_or_scope.id)
    end
  
    private
  
    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email,
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end