class OpportunitiesController < ApplicationController
    before_action :check_auth

    def index
        @opportunities = Opportunity.all

        if !params[:freq].nil?
          @opportunities = @opportunities.filter_by_frequency(params[:freq])
        end
        if !params[:distance].nil?
          if !params[:location].nil?
              loc = params[:location]
          else
              loc = "Durham, NC 27708"
          end
          @opportunities = @opportunities.filter_by_distance(loc, params[:distance].to_i)
        end

        tags = params[:tags]

        @opportunities = @opportunities.filter_by_tags(tags) if tags.present?

        # @opportunities = @opportunities.sort_by_default
        # if params[:upcoming] == '1'
        #   @opportunities = @opportunities.sort_by_upcoming
        # end
        @opportunities = @opportunities.sorting(params[:upcoming], params[:highrated])

        #Puts featured posts at the top
        @opportunities = @opportunities.reorder(featured: :desc)

        @opportunities = @opportunities.paginate(:page => params[:page], :per_page => 5)
        @organizations = Organization.all
        # opportunities for org admin view

        respond_to do |format|
          format.html
          format.js
        end
    end

    def like
        @opportunity = Opportunity.find(params[:id])
        @organization = @opportunity.organization

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

        redirect_to @opportunity
    end

    def show
        @opportunity = Opportunity.find(params[:id])
        @current_user = current_user
        @organization = @opportunity.organization

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

        #Code for volunteer to add/remove opp from interested
        if !current_user.opportunities.find_by_id(params[:id])
            @message = "Click to sign up"
        else
            @message = "I'm signed up!"
        end
        # create notifications for organization

        if !params[:add].nil? && !current_user.opportunities.find_by_id(params[:id])
            current_user.opportunities << @opportunity
            @opportunity.organization.users.each do |user|
              Notification.create(recipient: user, actor: current_user, action: "has_signed_up_for", notifiable: @opportunity)
            end
            if @opportunity.require_approvals?
              UserMailer.signup_pending(current_user.email, @opportunity).deliver_now
            else
              UserMailer.signup_confirm(current_user.email, @opportunity).deliver_now
            end
            redirect_to @opportunity
        elsif !params[:add].nil?
            current_user.opportunities.delete(@opportunity)
            @opportunity.organization.users.each do |user|
              Notification.create(recipient: user, actor: current_user, action: "has_removed_their_sign_up_from", notifiable: @opportunity)
            end
            UserMailer.unsignup(current_user.email, @opportunity).deliver_now
            redirect_to @opportunity
        end

        #Code for admin to add/remove opp from featured
        if @opportunity.featured?
            @feat = "Unfeature this post"
        else
            @feat = "Feature this post"
        end

        if @opportunity.featured? && !params[:feature].nil?
            @opportunity.update_attribute(:featured, false)
            redirect_to @opportunity
        elsif !@opportunity.featured? && !params[:feature].nil?
            @opportunity.update_attribute(:featured, true)
            redirect_to @opportunity
        end

    end

    def clone
        @opportunity = Opportunity.new
        @opportunity_og = Opportunity.find(params[:id])
        @address = @opportunity_og.address
        @tags = Tag.all
    end

    def new
        @tags = Tag.all
        @opportunity = Opportunity.new
    end

    def create
        @organization = current_user.organization
        params["opportunity"]["date"] =  Opportunity.convert_date_string(params["opportunity"]["date"], params["time"])
        @opportunity = Opportunity.new(opportunities_params)
        address = {}
        params["opportunity"]["address"].each {|k,v| address[k]=v}
        @opportunity.build_address(address)
        @opportunity.active = 1
        tags = params[:tags]

        if !tags.nil?
            tags.each do |tag|
                @opportunity.tags << Tag.where(name: tag)
            end
        end

        if @organization.opportunities << @opportunity
            redirect_to @opportunity
        else
            @tags = Tag.all
            render 'new'
        end

    end

    def edit
        @opportunity = Opportunity.find(params[:id])
        @address = @opportunity.address
        @tags = Tag.all
    end

    def update
        params["opportunity"]["date"] =  Opportunity.convert_date_string(params["opportunity"]["date"], params["time"])
        @opportunity = Opportunity.find(params[:id])
        address = {}
        params["opportunity"]["address"].each {|k,v| address[k]=v}
        @opportunity.build_address(address)

        @opportunity.tags.each do |n|
            @opportunity.tags.delete(n)
        end

        tags = params[:tags]

        if !tags.nil?
            tags.each do |tag|
                @opportunity.tags << Tag.where(name: tag)
            end
        end

        if(@opportunity.update(opportunities_params))
            redirect_to @opportunity
        else
            render 'edit'
        end

        @opportunity.users.all.each do |user|
          Notification.create(recipient: user, actor: current_user, action: "has_updated", notifiable: @opportunity)
        end
    end

    def destroy
        @opportunity = Opportunity.find(params[:id])
        @opportunity.destroy

        redirect_to which_feed
    end

    def contact_volunteers
      @opportunity = Opportunity.find(params[:id])
    end

    def view_volunteers
        @opportunity = Opportunity.find(params[:opp])
        if !params[:user_id].nil?
            @user = User.find(params[:user_id])
        end
        if !params[:approve].nil?
            if @user.approvals.first.nil?
                app = Approval.new(name:@user.name)
                app.user = @user
                app.save
            end
            @opportunity.approvals << @user.approvals.first
            Notification.create(recipient: @user, actor: current_user, action: "has_approved_your_sign-up_for", notifiable: @opportunity)
            UserMailer.signup_approved(@user.email, @opportunity).deliver_now
        elsif !params[:remove].nil?
            @user.approvals.first.opportunities.delete(@opportunity)
            Notification.create(recipient: @user, actor: current_user, action: "has_removed_approval_for", notifiable: @opportunity)
            UserMailer.signup_unapproved(@user.email, @opportunity).deliver_now
        end
    end

    def contact
      data = params[:body]
      subject=params[:subject]
      @opportunity = Opportunity.find(params[:id])
      to = params[:to].split(',')
      cc = params[:cc].split(',')
      bcc = params[:bcc].split(',')
      UserMailer.contact_all_volunteers(data,to,cc,bcc,subject).deliver_now
      redirect_to @opportunity
    end

    private def opportunities_params
        params.require(:opportunity).permit(:date, :title, :description, :next_steps, :volunteers_needed, :hours, :poc_name, :poc_email, :poc_phone, :ongoing, :requirements, :preferences, :require_approvals)
    end
end
