class AdminMailerPreview < ActionMailer::Preview
  def new_org
    AdminMailer.with(org: Organization.first).new_org
  end

  def org_admin_access
    AdminMailer.org_admin_access("Bob", Organization.first)
  end
end
