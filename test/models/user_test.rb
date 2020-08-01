require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user is created" do
    user = User.create(name: "Jane Doe", email: "jd123@email.com", phone: "(567)555-1234", car: false)
    assert user.name == "Jane Doe"
    assert user.email == "jd123@email.com"
    assert user.phone == "(567)555-1234"
    assert user.car == false
  end
end
