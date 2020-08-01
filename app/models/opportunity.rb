require 'date'

class Opportunity < ApplicationRecord

    validates :description, :volunteers_needed, :title, :date, :presence => true
    validates :description, :length => {:minimum => 5}
    validates :date, exclusion: { in: %w("mm/dd/yyyy") }

    has_and_belongs_to_many :tags
    belongs_to :organization
    has_many :pictures, :as => :imageable, :dependent => :delete_all
    has_and_belongs_to_many :users
    has_one :address, as: :locatable
    accepts_nested_attributes_for :address
    has_many :archived_opportunities, dependent: :destroy
    has_and_belongs_to_many :approvals
    has_many :feedbacks

    geocoded_by :location
    after_validation :geocode

    def location
        if self.address.nil?
            "Durham, NC 27708"
        else
            [self.address.street, self.address.city, self.address.state, self.address.zip].compact.join(', ')
        end
    end

    def self.convert_date_string(date, time)
        DateTime.parse(date + "T" + time.to_s + ":00").to_time.to_i
    end

    def display_date_time(date)
        temp = Time.at(date.to_i).strftime("%Y %m %d %H %M %S")
        arr = temp.split
        d = DateTime.new(arr[0].to_i, arr[1].to_i, arr[2].to_i, arr[3].to_i, arr[4].to_i, arr[5].to_i)
        d.strftime("%a, %b %d at %I:%M %p")
    end

    def display_date(date)
        temp = Time.at(date.to_i).strftime("%Y %m %d %H %M %S")
        arr = temp.split
        d = DateTime.new(arr[0].to_i, arr[1].to_i, arr[2].to_i, arr[3].to_i, arr[4].to_i, arr[5].to_i)
        d.strftime("%Y-%m-%d")
    end

    def display_date_pretty(date)
      temp = Time.at(date.to_i).strftime("%Y %m %d %H %M %S")
      arr = temp.split
      d = DateTime.new(arr[0].to_i, arr[1].to_i, arr[2].to_i, arr[3].to_i, arr[4].to_i, arr[5].to_i)
      d.strftime("%a, %b %d")
  end

    def display_time(date)
      temp = Time.at(date.to_i).strftime("%Y %m %d %H %M %S")
      arr = temp.split
      d = DateTime.new(arr[0].to_i, arr[1].to_i, arr[2].to_i, arr[3].to_i, arr[4].to_i, arr[5].to_i)
      d.strftime("%H:%M")
    end

    def display_location(location)
        arr = location.split(", ")
        l = "#{arr[0]}, #{arr[1]}"
    end

    def convert_date_string(date, time)
    end

    def self.update_active
      Opportunity.where(active: true).each do |opportunity|
        if opportunity.date <= Time.now.to_i && opportunity.ongoing == false
          opportunity.active = 0
          opportunity.save
        end
      end
    end

    def self.hours_this_week
      start_date = (Date.today - Date.today.wday).to_time.to_i
      end_date = Time.now.to_i
      hrs = 0
      Opportunity.all.each do |opportunity|
        if opportunity.date >= start_date && opportunity.date < end_date
          hrs += opportunity.hours * opportunity.users.count
        end
      end
      ArchivedOpportunity.all.each do |archived|
        if archived.date >= start_date && archived.date < end_date
          hrs += archived.hours
        end
      end  
      hrs
    end

    def self.hours_of_week(start_date, end_date)
      hrs = 0
      Opportunity.all.each do |opportunity|
        if opportunity.date >= start_date && opportunity.date < end_date
          hrs += opportunity.hours * opportunity.users.count
        end
      end
      ArchivedOpportunity.all.each do |archived|
        if archived.date >= start_date && archived.date < end_date
          hrs += archived.hours
        end
      end  
      hrs
    end

    def self.hours_this_month
      start_date = Date.today.at_beginning_of_month.to_time.to_i
      end_date = Time.now.to_i
      hrs = 0
      Opportunity.all.each do |opportunity|
        if opportunity.date >= start_date && opportunity.date < end_date
          hrs += opportunity.hours * opportunity.users.count
        end
      end
      ArchivedOpportunity.all.each do |archived|
        if archived.date >= start_date && archived.date < end_date
          hrs += archived.hours
        end
      end  
      hrs
    end

    def self.hours_of_month(start_date, end_date)
      hrs = 0
      Opportunity.all.each do |opportunity|
        if opportunity.date >= start_date && opportunity.date < end_date
          hrs += opportunity.hours * opportunity.users.count
        end
      end
      ArchivedOpportunity.all.each do |archived|
        if archived.date >= start_date && archived.date < end_date
          hrs += archived.hours
        end
      end  
      hrs
    end

    def self.hours_of_month_where(start_date, end_date, tag)
      hrs = 0
      Opportunity.joins(:tags).where(tags: { name: tag}).each do |opportunity|
        if opportunity.date >= start_date && opportunity.date < end_date
          hrs += opportunity.hours * opportunity.users.count
          hrs += opportunity.archived_opportunities.all.pluck(:hours).sum
        end
      end
      hrs
    end

    def self.filter_by_distance(current_location, distance_limit)
        if current_location == "west"
            current_location = [36.000933, -78.938221]
        elsif current_location == "east"
            current_location = [36.005995, -78.914716]
        elsif current_location == "swift"
            current_location = [36.002677, -78.921668]
        end
        Opportunity.near(current_location, distance_limit, :units => :mi)
    end

    def distance_from(location: [36.000933, -78.938221])
      opp_coords = Geocoder.coordinates(address.printable_address)
      Geocoder::Calculations.distance_between(location, opp_coords).round(1)
    end

    def self.filter_by_frequency(ongoing)
        if ongoing == "ongoing"
            Opportunity.where(ongoing: true)
        else
            Opportunity.where(ongoing: false)
        end
    end

    # def self.filter_by_approved
    #   Opportunity.where(organization.approved: true)
    # end

    def self.filter_by_tags(arr)
      opportunities = Opportunity.none
      arr.each do |tag|
          opportunities = opportunities.or(Opportunity.joins(:tags).where(tags: { name: tag}))
      end
      opportunities
    end

    # def self.sorting(upcoming, highrated)
    #   if upcoming.nil? && highrated.nil?
    #     Opportunity.order(created_at: :desc)
    #   elsif upcoming.nil? && !highrated.nil?
    #     Opportunity.order(rating: :desc, created_at: :desc)
    #   elsif !upcoming.nil? && highrated.nil?
    #     Opportunity.order(:date, created_at: :desc)
    #   else
    #     Opportunity.order(:date, rating: :desc, created_at: :desc)
    #   end
    # end

    def self.sorting(upcoming, highrated)
      if upcoming == 0 && highrated == 0
        Opportunity.reorder(created_at: :desc)
      elsif upcoming == 0 && highrated == 1
        Opportunity.reorder(likes: :desc, created_at: :desc)
      elsif upcoming == 1 && highrated == 0
        Opportunity.reorder(:date, created_at: :desc)
      else
        Opportunity.reorder(:date, likes: :desc, created_at: :desc)
      end
    end

    def self.update_likes
      Opportunity.where(active: true).each do |opportunity|
        opportunity.likes = opportunity.organization.ratings.count
        opportunity.save
      end
    end
    # def self.sort_by_default
    #   Opportunity.order(created_at: :desc)
    # end
    # def self.sort_by_upcoming
    #   Opportunity.reorder(:date)
    # end

    def self.org_opps(user)
      Opportunity.where(organization_id: user.organization_id)
    end
end
