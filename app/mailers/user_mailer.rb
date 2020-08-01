class UserMailer < ApplicationMailer
  default to: "mollyapsel@gmail.com",
          from: 'bulletin@duke.edu'

  def contact_all_volunteers(data,to,cc,bcc,subject)
    @body=data
    mail(to: to, cc: cc, bcc: bcc, subject: subject)
  end

  def approved_org(email, org)
    @org = org
    mail(to: email, subject: "Your organization has been approved")
  end

  def denied_org(email, org)
    @org = org
    mail(to: email, subject: "Your new organization request has been denied")
  end

  def approved_org_adm(email, org)
    @org = org
    mail(to: email, subject: "You have been approved as an admin for #{@org}")
  end

  def denied_org_adm(email, org)
    @org = org
    mail(to: email, subject: "Your request for admin access has been denied")
  end

  def signup_pending(to, opp)
    @opp = opp
    mail(to: to, subject: "Confirmation of sign up, pending approval")
  end

  def signup_confirm(to, opp)
    @opp = opp
    mail(to: to, subject: "Confirmation of sign up for #{@opp.title}")
  end

  def signup_approved(to, opp)
    @opp = opp
    mail(to: to, subject: "Sign-up for #{@opp.title} has been approved")
  end

  def signup_unapproved(to, opp)
    @opp = opp
    mail(to: to, subject: "Approval for #{@opp.title} has been removed")
  end

  def unsignup(to, opp)
    @opp = opp
    mail(to: to, subject: "Confirmation: sign-up cancelled")
  end

  def test_email
    emails = ["zg63@duke.edu", "mollyapsel@gmail.com", "joselyn.mcdonald@duke.edu", "danai.adkisson@duke.edu", "anna.mollard@duke.edu", "joshua.sauter@duke.edu"]
    mail(to: emails,  subject: "TESTING")
  end
end
