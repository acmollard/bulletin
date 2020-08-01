require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  test "picture is created" do
    picture = Picture.create(name: "Profile Pic")
    assert picture.name == "Profile Pic"
  end

=begin
  test "picture is created part 2" do
    picture = Picture.create (name: "Profile Picture", imageable_id: 2000, imageable_type: "type1")
    assert picture.name == "Profile Picture"
    assert picture.imageable_id == 2000
    assert picture.imageable_type =="type1"
  end
=end
end

