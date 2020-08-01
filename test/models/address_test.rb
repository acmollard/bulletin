require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  test "country gets created" do
    address = Address.create(country: "USA")
    assert address.country == "USA"
  end

  test "state gets created" do
    address = Address.create(state: "North Carolina")
    assert address.state == "North Carolina"
  end

  test "street gets created" do
    address = Address.create(street: "123 Main St.")
    assert address.street == "123 Main St."
  end

  test "zip gets created" do
    address = Address.create(zip: 22039)
    assert address.zip == 22039
  end

  test "all get created" do
    address = Address.create(country: "United States", state: "NC", street: "Seasame St.", zip: 22187)
    assert address.country == "United States"
    assert address.state == "NC"
    assert address.street == "Seasame St."
    assert address.zip == 22187
  end
end

# FROM GENERAL_LOCATION_TEST
# require 'test_helper'

# class GeneralLocationTest < ActiveSupport::TestCase
#   test "country gets created" do
#     general_location = GeneralLocation.create(country: "USA")
#     assert general_location.country == "USA"
#   end

#   test "state gets created" do
#     general_location = GeneralLocation.create(state: "North Carolina")
#     assert general_location.state == "North Carolina"
#   end

#   test "zip get created" do
#     general_location = GeneralLocation.create(zip: 22039)
#     assert general_location.zip == 22039
#   end

#   test "all get created" do
#     general_location = GeneralLocation.create(country: "United States", state: "NC", zip: 22015)
#     assert general_location.country == "United States"
#     assert general_location.state == "NC"
#     assert general_location.zip == 22015
#   end
# end

