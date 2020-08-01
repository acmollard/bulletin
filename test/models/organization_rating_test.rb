require 'test_helper'

class OrganizationRatingTest < ActiveSupport::TestCase
  test "rating gets created" do
    organization_rating = OrganizationRating.create(rating: 5)
    assert organization_rating.rating == 5
  end
end
