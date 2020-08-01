require 'test_helper'

class OpportunityTest < ActiveSupport::TestCase
  test "create opportunity" do
    assert opportunity = Opportunity.create(date: 111, description: "Fun!", volunteers_needed: 5)
    assert opportunity.location == "Durham, NC 27708"
  end

  test "opportunity has address" do
    assert add = Address.create(
        country:"USA", 
        state: "FL", 
        city:  "Orlando",
        street:"200 Epcot Center Dr", 
        zip:32821, 
        locatable_id:Faker::IDNumber.brazilian_citizen_number, 
        locatable_type:"Opportunity"
    )
    assert opportunity = Opportunity.new(date: 111, description: "Disney World!", volunteers_needed: 5)
    assert opportunity.address = add
    assert opportunity.location == "200 Epcot Center Dr, Orlando, FL, 32821"
    assert opportunity.to_coordinates.nil? == false
  end
end
