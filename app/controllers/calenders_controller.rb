class CalendersController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_admin, only: %i[ new  index]
  require 'google/api_client/client_secrets.rb'
  require 'google/apis/calendar_v3'
  require 'date'

  # GET /profiles or /profiles.json
  def index
    get_calendars
  end

  
def callback_apple
  admin = Admin.from_google(from_google_params)
  
  if admin.present?
    sign_out_all_scopes
    flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Apple'
    sign_in_and_redirect admin, event: :authentication
  else
    flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
    redirect_to new_admin_session_path
  end

end

  def get_calendars
    @calender_event=[]

    @calender_event_weekly=[]

    # Initialize Google Calendar API
    service = Google::Apis::CalendarV3::CalendarService.new
    # Use google keys to authorize
    service.authorization = google_secret.to_authorization
    # Request for a new aceess token just incase it expired
    service.authorization.refresh!
    date = Date.today
    
    # # date.wday return week day
    end_date = date-date.wday
    start_date = date-date.wday+6
  calendar_id = "primary"
  response = service.list_events(calendar_id,
            max_results:   10,
            single_events: true,
            order_by:      "startTime",
            # time_min:      DateTime.now)
            time_max:      start_date.to_datetime.rfc3339,
            time_min:      end_date.to_datetime.rfc3339)

    @calender_event_weekly.push("message": "No upcoming events found") if response.items.empty?
    response.items.each do |event|
      start = event.start.date || event.start.date_time
      @calender_event_weekly.push({"description": event.summary , "date": start})
    end



    end_date = date
    start_date = date+1
    response = service.list_events(calendar_id,
    max_results:   10,
    single_events: true,
    order_by:      "startTime",
    # time_min:      DateTime.now)
    time_max:      start_date.to_datetime.rfc3339,
    time_min:      end_date.to_datetime.rfc3339)

    @calender_event.push("message": "No upcoming events found") if response.items.empty?
    response.items.each do |event|
      start = event.start.date || event.start.date_time
      @calender_event.push({"description": event.summary , "date": start})
    end

    
    @calender_event
    @calender_event_weekly
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def from_google_params
      @from_google_params ||= {
        uid: params[:id_token],
        email: "test1421@gmail.com",
        full_name: "test dev",
        avatar_url: "url"
      }
    end
    def set_admin
      @admin = Admin.find(params[:admin_id])
    end
  
  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => @admin.google_token,
          "refresh_token" => @admin.google_refresh_token,
          "client_id" => ENV['GOOGLE_OAUTH_CLIENT_ID'],
          "client_secret" => ENV['GOOGLE_OAUTH_CLIENT_SECRET'],
        }
      }
    )
  end
end
