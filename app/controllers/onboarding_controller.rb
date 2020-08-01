class OnboardingController < ApplicationController
    def onboard
    end
    def volunteer_partial
        respond_to do |format|
            format.html {
                render partial: 'onboarding/volunteer_partial'
            }
        end
    end
    def organization_partial
        respond_to do |format|
            format.html {
                render partial: 'onboarding/organization_partial'
            }
        end
    end

    def complete
        # register new organization
        if !params[:new_org].blank?
            current_user.name = params[:register_name]
            current_user.phone = params[:register_phone] unless params[:register_phone].blank?
            current_user.position = params[:register_position] unless params[:register_phone].blank?
            @organization = Organization.new
            @organization.name = params[:new_org]
            @organization.website = params[:website] unless params[:website].blank?
            if !params[:address].nil?
                address = {}
                params[:address].each {|k,v| address[k]=v}
                @organization.addresses.build(address)
                @organization.location = @organization.addresses.first.printable_address
            end
            @organization.email = params[:new_org_email] unless params[:new_org_email].blank?
            @organization.phone = params[:new_org_phone] unless params[:new_org_phone].blank?
            @organization.ein = params[:ein] unless params[:ein].blank?
            @organization.description = params[:org_description] unless params[:org_description].blank?
            if params[:registered] === "1"
                @organization.registered = true
            else
                @organization.registered = false
            end
            
            @organization.save
            current_user.type = OrgAdmin
            current_user.organization = @organization
            AdminMailer.with(org: @organization, name: current_user.name, phone: current_user.phone, position: current_user.position).new_org.deliver_now
            @admins = User.where(admin: true)
            @admins.each do |admin|
              Notification.create(recipient: admin, actor: current_user, action: "wants_to_join_your_platform", notifiable: @organization)
            end
            
            #Adding profile pic
            if (!params[:profile_pic].nil?)
                pfp = Picture.new(name: "Org#{@organization.id}pfp", imageable_id: @organization.id, imageable_type: "#{@organization.class}")
                pfp.image = params[:profile_pic]
                pfp.save!
                @organization.pictures << pfp
            end

        # join already registered organization
        elsif !params[:org].blank?
            current_user.name = params[:join_name]
            current_user.phone = params[:phone] unless params[:phone].blank?
            current_user.position = params[:position]  unless params[:position].blank?
            @organization = Organization.find_by_name(params["join-org-name"])
            current_user.type = "OrgAdmin"
            current_user.organization = @organization
            AdminMailer.with(phone: current_user.phone, position: current_user.position).org_admin_access(current_user.name, @organization).deliver_now
            orgadmins = @organization.users.where(admin: nil) - [current_user]
            orgadmins.each do |user|
              Notification.create(recipient: user, actor: current_user, action: "requests_admin_access_for", notifiable: @organization)
            end

        # volunteer
        else
            current_user.name = params[:name]
            current_user.phone = params[:phone] unless params[:phone].blank?
            current_user.position = params[:position] unless params[:position].blank?
            current_user.gender = params[:gender] unless params[:gender].blank? || params[:gender] === "Gender"
            current_user.affiliation = params[:affiliation] unless params[:affiliation].blank? || params[:affiliation] === "Affiliation"
            current_user.major = params[:major] unless params[:major].blank?
            current_user.grad_year = params[:grad_year] unless params[:grad_year].blank?
            current_user.grad_year = params[:undergrad_year] unless params[:undergrad_year].blank?
            current_user.grad_year = params[:alumni_year] unless params[:alumni_year].blank?
            current_user.department = params[:department] unless params[:department].blank?
            current_user.school = params[:school] unless params[:school].blank? || params[:school] === "School"
            current_user.degree = params[:degree] unless params[:degree].blank?
            current_user.description = params[:description] unless params[:description].blank?
            if !params["user_address"].nil?
                user_address = {}
                params["user_address"].each {|k,v| user_address[k]=v}
                current_user.build_address(user_address)
            end
            tags = params[:tags]
            if !tags.nil?
                tags.each do |tag|
                    current_user.tags << Tag.where(name: tag)
                end
            end

            #Adding profile pic
            if (!params[:profile_pic].nil?)
                pfp = Picture.new(name: "User#{current_user.id}pfp", imageable_id: current_user.id, imageable_type: "#{current_user.class}")
                pfp.image = params[:profile_pic]
                pfp.save!
                current_user.pictures << pfp
            end
        end

        current_user.save
    end
end
