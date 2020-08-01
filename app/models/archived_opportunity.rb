class ArchivedOpportunity < ApplicationRecord
    belongs_to :opportunity, required: false
    has_and_belongs_to_many :users
end
