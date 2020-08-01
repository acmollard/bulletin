class AdminMailer < ApplicationMailer
  @admins = User.where(admin: true).pluck(:email)
  default to: -> { @admins },
          from: 'bulletin@duke.edu'

# to call: AdminMailer.with(org: Organization.first).new_org.deliver_now
  def new_org
    @org = params[:org]
    @name = params[:name]
    @phone = params[:phone]
    @position = params[:position]
    @web = @org.website
    @address = @org.addresses.first.printable_address
    @ein = @org.ein
    @desc = @org.description
    @registered_vcd = @org.registered
    @url = "https://bulletin.colab.duke.edu/" #TODO: UPDATE WITH REAL URL
    mail(subject: "New Organization Request: #{@org.name}")
  end

  def org_admin_access(name, org)
    @name = name
    @org = org
    @phone = params[:phone]
    @position = params[:position]
    orgadmins = org.users.pluck(:email)
    @url = "https://bulletin.colab.duke.edu/" #TODO: UPDATE WITH REAL URL
    mail(to: orgadmins, subject: "#{@name} (#{@org.name}) Requests Organization Admin Access")
  end
end
