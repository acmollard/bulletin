class Feedback < ApplicationRecord
    belongs_to :user
    belongs_to :organization
    belongs_to :opportunity
end
