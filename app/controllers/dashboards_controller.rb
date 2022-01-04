class DashboardsController < ApplicationController
    def show
        # omniauth = request.env["omniauth.auth"]
        # email = request.env['omniauth.auth']
        # puts request.env['omniauth.auth'].to_json
        # puts '====================================='


        require 'google/api_client/client_secrets.rb'
        require 'google/apis/calendar_v3'

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


      def get_calendars
        # Initialize Google Calendar API
        service = Google::Apis::CalendarV3::CalendarService.new
        # Use google keys to authorize
        service.authorization = google_secret.to_authorization
        # Request for a new aceess token just incase it expired
        service.authorization.refresh!
       
        calendar_id = "primary"
         response = service.list_events(calendar_id,
                                   max_results:   10,
                                   single_events: true,
                                   order_by:      "startTime",
                                   time_min:      DateTime.now.rfc3339)
            puts "Upcoming events:"
            puts "No upcoming events found" if response.items.empty?
            response.items.each do |event|
            start = event.start.date || event.start.date_time
            puts "- #{event.summary} (#{start})"
            end
      end
  end

