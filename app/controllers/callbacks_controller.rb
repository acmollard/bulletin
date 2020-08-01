class CallbacksController < Devise::OmniauthCallbacksController
    def create_user_from_login(type)
        auth = request.env["omniauth.auth"]
        if user_signed_in?
            @user = current_user
            sign_in_and_redirect @user
            flash[:error_message] = "You are signed in as #{current_user.name} with #{current_user.email}. If you meant to log in as someone else, log out and try again."
        else
            @user = User.from_omniauth(auth)
            if @user.persisted?
              sign_in_and_redirect @user
            else
              session["devise.#{type}_data"] = auth.except(:extra)
              redirect_to new_user_registration_url
            end
        end
    end

    def duke
        create_user_from_login("duke")
    end

    def facebook
        create_user_from_login("facebook")
    end

    def google_oauth2
        create_user_from_login("google_oauth2")
    end

    def failure
        if user_signed_in?
            flash[:error_message] = "You are signed in as #{current_user.name} with #{current_user.email}. If you meant to log in as someone else, log out and try again."
        else
            flash[:error_message] = "Login unsuccessful: try again"
        end
        redirect_to new_user_session_path
    end

end
