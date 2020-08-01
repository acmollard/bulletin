class AdminController < ApplicationController
    before_action :check_auth, :check_admin
    def admin_home
        $weekly_stats = Hash.new
        for i in 0..7
            date = Date.today - Date.today.wday + (7 * (i - 7))
            week_hours = Opportunity.hours_of_week(date.to_time.to_i, (date + 7).to_time.to_i)
            $weekly_stats[date.strftime("%b %d") + " - " + (date + 6).strftime("%b %d")] = week_hours
        end
        $monthly_stats = Hash.new
        for i in 0..11
            date = 1.year.ago.at_beginning_of_month.to_time + i.month
            month_hours = Opportunity.hours_of_month(date.to_time.to_i, (date + 1.month).to_time.to_i)
            $monthly_stats[date.strftime("%b")] = month_hours
        end
        $opptagsweek = Hash.new
        Tag.all.each do |tag|
            $opptagsweek[tag.name] = Opportunity.hours_of_month_where((Date.today - Date.today.wday).to_time.to_i, Date.today.to_time.to_i, tag.name)
        end
        $opptagsweek = $opptagsweek.to_a.reverse
        $opptagsmonth = Hash.new
        Tag.all.each do |tag|
            $opptagsmonth[tag.name] = Opportunity.hours_of_month_where(Date.today.at_beginning_of_month.to_time.to_i, Date.today.to_time.to_i, tag.name)
        end
        $opptagsmonth = $opptagsmonth.to_a.reverse
        $opptagsyear = Hash.new
        Tag.all.each do |tag|
            $opptagsyear[tag.name] = Opportunity.hours_of_month_where(Date.today.beginning_of_year.to_time.to_i, Date.today.to_time.to_i, tag.name)
        end
        $opptagsyear = $opptagsyear.to_a.reverse
        $opp_tag_trend = Hash.new
        $opp_tag_percs = Hash.new
        Tag.all.each do |tag|
            monthly_tag = Hash.new
            monthly_tag_percs = Hash.new
            for i in 0..11
                date = 1.year.ago.at_beginning_of_month.to_time + i.month
                month_hours = Opportunity.hours_of_month_where(date.to_time.to_i, (date + 1.month).to_time.to_i, tag.name)
                date_key = date.strftime("%b")
                monthly_tag[date_key] = month_hours
                if $monthly_stats[date_key] != 0
                    monthly_tag_percs[date_key] = month_hours * 100 / $monthly_stats[date_key]
                else
                    monthly_tag_percs[date_key] = 0
                end
            end
            $opp_tag_trend[tag.name] = monthly_tag
            $opp_tag_percs[tag.name] = monthly_tag_percs
        end
        $positions_available = 0
        $opportunities_available = 0
        $positions_filled = 0
        Opportunity.all.each do |opportunity|
            if opportunity.date > Date.today.to_time.to_i
                $positions_available += opportunity.volunteers_needed - opportunity.users.count
                $positions_filled += opportunity.users.count
                $opportunities_available += 1
            end
        end
        if !params[:name].nil?
            new_admin = OrgAdmin.create(
                name:params[:name],
                email:params[:email],
                department:params[:department],
                admin:true,
                password:"1234567",
                approved:true
            )
            dca = Organization.find_by_name("Duke Office of Durham and Community Affairs")
            new_admin.organization = dca
            if new_admin.save
                flash[:success] = "We have created an admin account for #{new_admin.name}! Instruct #{new_admin.name} to log in to the Bulletin with Duke or Google, depending on the email you provided."
            else
                if params[:name].empty? || params[:email].empty?
                    flash[:error_message] = "Make sure all fields are filled out."
                elsif User.find_by_email(params[:email])
                    flash[:error_message] = "The email #{params[:email]} is already associated with an administrator."
                else
                    flash[:error_message] = "Something went wrong. Try again."
                end
            end
        end
    end

    def statistics
        respond_to do |format|
            format.html {
                render partial: 'stat'
            }
        end
    end

    def requests
      @notifications = Notification.where(recipient: current_user).reverse
        respond_to do |format|
            format.html {
                render partial: 'request'
            }
        end
    end

    def organizations
        respond_to do |format|
            format.html {
                render partial: 'organization'
            }
        end
    end

    def approve
      n = Notification.find_by(id: params[:notif])
      n.actor.organization.update_attribute(:approved, true)
      n.actor.update_attribute(:approved, true)
      UserMailer.approved_org(n.actor.email, n.actor.organization.name).deliver_now
    end

    def deny
      n = Notification.find_by(id: params[:notif])
      n.actor.update_attribute(:approved, false)
      UserMailer.approved_org(n.actor.email, n.actor.organization.name).deliver_now
    end
end
