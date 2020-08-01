class Approval < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :opportunities
end
