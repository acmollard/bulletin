class ApplicationController < ActionController::Base
    def check_auth
        if !user_signed_in?
            authenticate_user!
        end
    end

    def check_admin
        unless current_user.admin?
            redirect_to "/error403"
        end
    end

    def check_org_admin
        unless current_user.is_a? OrgAdmin
            redirect_to "/error403"
        end
    end

    protected

    def after_sign_in_path_for(resource)
        # return the path based on resource
        homepage = "/profile_volunteer"
        if current_user.sign_in_count == 1 && !current_user.admin?
            homepage = "/onboard"
        elsif current_user.admin?
            homepage = "/admin"
        elsif current_user.is_a? OrgAdmin
            homepage = current_user.organization
        end
        homepage
    end

    helper_method :which_feed

    def which_feed
        feed = "/feed_volunteer"
        if !current_user.admin? && current_user.type == "OrgAdmin"
            feed = "/feed_organization"
        end
        feed
    end

end
