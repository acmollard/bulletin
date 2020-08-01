class DashboardController < ApplicationController
  def index
      @current_user = current_user
  end
  def error404
  end
  def error500
  end
  def error403
  end
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  def hours
    @organizations = Organization.all
    @opportunities = Opportunity.joins(:users).where(users: { id: current_user.id})
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def notifs
    @notifications = Notification.where(recipient: current_user).reverse
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def history
    @user = current_user
    @opportunities = Opportunity.where(id: ArchivedOpportunity.joins(:users).where(users: { id: current_user.id}).pluck(:opportunity_id))
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  # filters opportunities within the distance from slider from user location
  def feed_volunteer
    #blowup
    check_auth
    if params[:page].nil?
      Opportunity.update_active
      $opportunities = Opportunity.where(active: true)
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
    if !params[:distance].nil?
      if !params[:location].nil?
          loc = params[:location]
      else
          loc = "Durham, NC 27708"
      end
      $opportunities = $opportunities.filter_by_distance(loc, params[:distance].to_i)
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

  def edit_user
    @current_user = current_user
    @address = current_user.address
    @tags = Tag.all
  end

  def update_user
    @current_user = current_user
    if(update_params)
      redirect_to profile_volunteer_path
    else
      render 'edit_user'
    end
  end

  private def update_params
    @current_user.update(major: nil, school: nil, degree: nil, grad_year: nil, department: nil)
    #Updating user name, gender, phone, email, affiliation, and description
    @current_user.update(name: params[:user][:name], gender: params[:gender], phone: params[:user][:phone], affiliation: params[:affiliation], description: params[:description].html_safe)
    #Updating address
    if @current_user.address.nil?
      if !params[:address].nil?
        user_address = {}
        params[:address].each {|k,v| user_address[k]=v}
        @current_user.build_address(user_address)
        @current_user.save
      end
    else
      @current_user.address.update(street: params[:user][:street], city: params[:user][:city], state: params[:user][:state], zip: params[:user][:zip])
    end
    #Updating major
    case @current_user.affiliation
    when "Undergraduate student"
      if params[:user][:major].nil?
        @current_user.update(major: params[:major], grad_year: params[:grad_year])
      else
        @current_user.update(major: params[:user][:major], grad_year: params[:user][:grad_year])
      end
    when "Graduate/professional student"
      if params[:user][:school].nil?
        @current_user.update(school: params[:school], grad_year: params[:grad_year])
      else
        @current_user.update(school: params[:user][:school], grad_year: params[:user][:grad_year])
      end
    when "Alumni"
      if params[:user][:degree].nil?
        @current_user.update(degree: params[:degree], grad_year: params[:grad_year])
      else
        @current_user.update(degree: params[:user][:degree], grad_year: params[:user][:grad_year])
      end
    else
      if params[:user][:department].nil?
        @current_user.update(department: params[:department])
      else
        @current_user.update(department: params[:user][:department])
      end
    end
    #Updating tags
    @current_user.tags.each do |n|
      @current_user.tags.delete(n)
    end
    tags = params[:tags]
    if !tags.nil?
        tags.each do |tag|
            @current_user.tags << Tag.where(name: tag)
        end
    end
    #Adding profile pic
    if !params[:user][:profile_pic].nil?
      if !current_user.pictures.nil? && !current_user.pictures.find_by_name("User#{current_user.id}pfp").nil?
        current_pfp = current_user.pictures.find_by_name("User#{current_user.id}pfp")
        current_user.pictures.delete(current_pfp)
        Picture.delete(current_pfp)
      end
      pfp = Picture.new(name: "User#{current_user.id}pfp", imageable_id: current_user.id, imageable_type: "#{current_user.class}")
      pfp.image = params[:user][:profile_pic]
      pfp.save!
      current_user.pictures << pfp
    else
      true
    end
  end

  def profile_volunteer
    check_auth
    current_user.opportunities.each do |opportunity|
      if (!opportunity.active || opportunity.ongoing) && params.has_key?(opportunity.id.to_s)
        if !params[:description].blank?
          feedback = Feedback.new(description:params[:description], anonymous:!params[:anonymous].nil?)
          feedback.organization = opportunity.organization
          feedback.user = current_user
          feedback.opportunity = opportunity
          feedback.save
          opportunity.organization.users.each do |user|
            Notification.create(recipient: user, actor: current_user, action: "has_submitted_feedback_for_your_organization", notifiable: feedback)
          end
        end
        if params[opportunity.id.to_s] == "confirm"
          archived = ArchivedOpportunity.new(title:opportunity.title,
          hours:params["hours"], organization:opportunity.organization.name)
          opportunity.archived_opportunities << archived
          current_user.archived_opportunities << archived
          if opportunity.ongoing == false
            archived.date = opportunity.date
            archived.save
            current_user.opportunities.delete(opportunity)
          else
            archived.date = opportunity.created_at
            archived.save
          end
        elsif params[opportunity.id.to_s] == "deny"
          current_user.opportunities.delete(opportunity)
        end
      end
    end
    @current_user = current_user
    @opportunities = current_user.opportunities
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
