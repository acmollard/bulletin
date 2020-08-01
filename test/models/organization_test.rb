require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "organization is created" do
    organization = Organization.create(name: "McDonald", description: "Burgers!")
    assert organization.name == "McDonald"
    assert organization.description == "Burgers!"
  end
end
