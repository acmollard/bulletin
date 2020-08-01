class OrganizationController < ApplicationController
    before_action :check_auth
    def secret
    end
    def profile_organization
        @opportunities = Opportunity.all.org_opps(current_user)
        @organization = current_user.organization

        $weekly_stats = Hash.new
        for i in 0..4
            date = Date.today - Date.today.wday + (4 * (i - 4))
            week_hours = @organization.hours_during(date.to_time.to_i, (date + 7).to_time.to_i)
            $weekly_stats[date.strftime("%b %d") + " - " + (date + 6).strftime("%b %d")] = week_hours
        end

        $monthly_stats = Hash.new
        for i in 0..5
            date = 1.year.ago.at_beginning_of_month.to_time + i.month
            month_hours = @organization.hours_during(date.to_time.to_i, (date + 1.month).to_time.to_i)
            $monthly_stats[date.strftime("%b")] = month_hours
        end
    end

    def feed_organization
        unless current_user.is_a?(OrgAdmin) || current_user.admin == true
            redirect_to "/error403"
        end

        if params[:page].nil?
            $opportunities = Opportunity.all.org_opps(current_user)
        end

        if params[:tags].nil?
            @tags = params[:mobile_tags]
        else
            @tags = params[:tags]
        end

        if params[:distance].nil?
            @slider = 15
        else
            @slider = params[:distance]
        end

        if !params[:freq].nil?
            $opportunities = $opportunities.filter_by_frequency(params[:freq])
        end

        if params[:tags].nil?
            tags = params[:mobile_tags]
        else
            tags = params[:tags]
        end

        $opportunities = $opportunities.filter_by_tags(tags) if !tags.nil?

        if !params[:highrated].nil?
            Opportunity.update_likes
        end

        #Puts featured posts at the top ONLY if no filter has been applied
        if params[:upcoming].nil? && params[:highrated].nil? && params[:page].nil?
            $opportunities = $opportunities.reorder(featured: :desc, created_at: :desc)
        elsif params[:upcoming].nil? && !params[:highrated].nil? && params[:page].nil?
            $opportunities = $opportunities.reorder(likes: :desc, created_at: :desc)
        elsif !params[:upcoming].nil? && params[:highrated].nil? && params[:page].nil?
            $opportunities = $opportunities.reorder(:date, created_at: :desc)
        elsif params[:page].nil?
            $opportunities = $opportunities.reorder(:date, likes: :desc, created_at: :desc)
        end

        $opportunities = $opportunities.paginate(:page => params[:page], :per_page => 5)

        @organizations = Organization.all

        @opportunities = $opportunities.distinct


        respond_to do |format|
            format.html
            format.js
        end
    end

    def notifications
        @notifications = Notification.where(recipient: current_user).reverse
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def stats
        @organization = Organization.find_by_id(params[:id])
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def volunteers
        @organization = Organization.find_by_id(params[:id])
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def histories
        @organization = Organization.find_by_id(params[:id])
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def opps
        @organization = Organization.find_by_id(params[:id])
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def reviews
        @organization = Organization.find_by_id(params[:id])
        respond_to do |format|
            format.js {render layout: false}
        end
    end

    def index
        @organizations = Organization.all
        respond_to do |format|
            format.html
            format.js
        end
    end

    def new
        @organization = Organization.new
    end

    def create
        @organization = Organization.new(organization_params)

        # if curent_user.opportunities << @organization
        #     redirect_to @organization
        # else
        #     render 'new'
        # end

        @organization.save
        redirect_to @organization
    end

    def like
        @organization = Organization.find(params[:id])

        if !params[:like].nil? && !@organization.ratings.include?(Rating.find_by(user_id: current_user.id))
            if current_user.ratings.first.nil?
                rating = Rating.new(name:current_user.name)
                current_user.ratings << rating
            else
                rating = current_user.ratings.first
            end
            @organization.ratings << rating
        elsif !params[:like].nil?
            @organization.ratings.delete(Rating.find_by(user_id: current_user.id))
        end

        redirect_to @organization
    end

    def show
        @current_user = current_user
        @organization = Organization.find(params[:id])

        $weekly_stats = Hash.new
        for i in 0..4
            date = Date.today - Date.today.wday + (4 * (i - 4))
            week_hours = @organization.hours_during(date.to_time.to_i, (date + 7).to_time.to_i)
            $weekly_stats[date.strftime("%b %d") + " - " + (date + 6).strftime("%b %d")] = week_hours
        end

        $monthly_stats = Hash.new
        for i in 0..5
            date = 1.year.ago.at_beginning_of_month.to_time + i.month
            month_hours = @organization.hours_during(date.to_time.to_i, (date + 1.month).to_time.to_i)
            $monthly_stats[date.strftime("%b")] = month_hours
        end

        respond_to do |format|
            format.html
            format.js
        end
    end

    def edit_custom
        @current_user = current_user
        @organization = current_user.organization
    end

    def update
        @organization = Organization.find(params[:id])
        @current_user = current_user

        if(update_params)
            redirect_to @organization
        else
            render 'edit'
        end
    end

    def destroy
        @organization = Organization.find(params[:id])
        @organization.destroy
        redirect_to organization_path
    end

    def approve
      n = Notification.find_by(id: params[:notif])
      n.actor.update_attribute(:approved, true)
      UserMailer.approved_org_adm(n.actor.email, n.actor.organization.name).deliver_now
    end

    def deny
      n = Notification.find_by(id: params[:notif])
      n.actor.update_attribute(:approved, false)
      UserMailer.denied_org_adm(n.actor.email, n.actor.organization.name).deliver_now
    end

    private def organization_params
        params.require(:organization).permit(:name, :description, :location, :website, :email, :phone)
    end
    
    private def update_params
        @current_user.update(name: params[:org_admin][:username], position: params[:org_admin][:position], phone: params[:org_admin][:phone])

        if @organization.addresses.first.blank?
            if !params[:org_admin][:street].nil?
              @organization.addresses.build(street: params[:org_admin][:street], city: params[:org_admin][:city], state: params[:org_admin][:state], zip: params[:org_admin][:zip])
              @organization.save
            end
        else
            @organization.addresses.first.update(street: params[:org_admin][:street], city: params[:org_admin][:city], state: params[:org_admin][:state], zip: params[:org_admin][:zip])
        end

        @organization.update(name: params[:org_admin][:name], website: params[:org_admin][:website], phone: params[:org_admin][:org_phone], email: params[:org_admin][:email], description: params[:description], location: @organization.addresses.first.printable_address)

        #Adding profile pic
        if !params[:org_admin][:profile_pic].nil?
            if !@organization.pictures.nil? && !@organization.pictures.find_by_name("User#{@organization.id}pfp").nil?
                current_pfp = @organization.pictures.find_by_name("Org#{@organization.id}pfp")
                current_user.pictures.delete(current_pfp)
                Picture.delete(current_pfp)
            end
            pfp = Picture.new(name: "Org#{@organization.id}pfp", imageable_id: @organization.id, imageable_type: "#{@organization.class}")
            pfp.image = params[:org_admin][:profile_pic]
            pfp.save!
            @organization.pictures << pfp
        else
            true
        end
    end
end
