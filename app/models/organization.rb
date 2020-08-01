class Organization < ApplicationRecord
    has_many :addresses, as: :locatable
    has_many :opportunities
    has_many :pictures, as: :imageable
    has_many :users
    has_and_belongs_to_many :organizations
    has_and_belongs_to_many :ratings
    has_many :feedbacks
    
    def volunteer_list()
        volunteers = []
        self.opportunities.all.each do |f|
            (volunteers.concat(f.users.all)).uniq
        end
        volunteers
    end

    def hours_during(start_date, end_date)
        hrs = 0
        self.opportunities.all.each do |opportunity|
            if opportunity.date >= start_date && opportunity.date < end_date
                hrs += opportunity.hours * opportunity.users.count
                hrs += opportunity.archived_opportunities.all.pluck(:hours).sum
            end
        end
        hrs
    end

    def weekly_volunteers()
        start_date = (Date.today - Date.today.wday).to_time.to_i
        end_date = Time.now.to_i
        volunteers = 0
        self.opportunities.all.each do |opportunity|
            if opportunity.date >= start_date && opportunity.date < end_date
                volunteers += opportunity.users.count
                volunteers += opportunity.archived_opportunities.all.count
            end
        end
        volunteers
    end

    def hours_this_week()
        start_date = (Date.today - Date.today.wday).to_time.to_i
        end_date = Time.now.to_i
        hrs = 0
        self.opportunities.all.each do |opportunity|
            if opportunity.date >= start_date && opportunity.date < end_date
                hrs += opportunity.hours * opportunity.users.count
                hrs += opportunity.archived_opportunities.all.pluck(:hours).sum
            end
        end
        hrs
    end
end 
