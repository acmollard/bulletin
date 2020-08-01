require 'test_helper'

class UserRatingTest < ActiveSupport::TestCase
  test "user_rating is created" do
    user_rating = UserRating.create(rating: 5)
    assert user_rating.rating == 5
  end
end
