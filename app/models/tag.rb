class Tag < ApplicationRecord
    has_and_belongs_to_many :opportunities
    has_and_belongs_to_many :users
end
