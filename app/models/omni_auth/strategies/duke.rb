require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Duke < OmniAuth::Strategies::OAuth2
      option :name, "duke"

      option :client_options, {
          site: ENV['BULLETIN_DUKE_OAUTH_HOST'],
          authorize_url: "https://oauth.oit.duke.edu/oidc/authorize",
          token_url: "https://oauth.oit.duke.edu/oidc/token"
        }

        uid { raw_info['dukeNetID'] }
        info do
          {
            name: raw_info['name'],
            email: raw_info['email'],
            netid: raw_info['dukeNetID'],
            duid: raw_info['dukeUniqueID']
          }
        end
        extra do
          { :raw_info => raw_info }
        end
        # TODO: use given eppn, extract netid, then pass to /identity API

        def raw_info
          # puts "="*50
          # puts access_token.get("https://oauth.oit.duke.edu//oidc/userinfo").parsed
          # puts "+"*50
          @raw_info ||= access_token.get("https://oauth.oit.duke.edu//oidc/userinfo").parsed
        end

        private
        def callback_url
          ENV["BULLETIN_DUKE_OAUTH_REDIRECT"]
          # options[:redirect_uri] || (full_host + script_name + callback_path) || super
        end

      # # These are called after authentication has succeeded. If
      # # possible, you should try to set the UID without making
      # # additional calls (if the user id is returned with the token
      # # or as a URI parameter). This may not be possible with all
      # # providers.
      # uid{ raw_info['id'] }

      # info do
      #   {
      #     :name => raw_info['name'],
      #     :email => raw_info['email']
      #   }
      # end

      # extra do
      #   {
      #     'raw_info' => raw_info
      #   }
      # end

      # def raw_info
      #   @raw_info ||= access_token.get('/me').parsed
      # end
    end
  end
end
