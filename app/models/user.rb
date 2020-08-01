class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, 
         :omniauthable, :omniauth_providers => [:duke, :facebook, :google_oauth2]
    has_many :notifications, foreign_key: :recipient_id
    has_many :availabilities
    has_one :address, as: :locatable
    has_and_belongs_to_many :opportunities
    has_many :pictures, as: :imageable
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :archived_opportunities
    accepts_nested_attributes_for :address
    belongs_to :organization, required: false
    has_many :ratings
    has_many :approvals
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

  def total_hours(user)
    hour_hash = {"Completed" => 0, "Pending" => 0, "In Progress" => 0}
    opportunities.each do |t|
      if t.active 
        hour_hash["In Progress"] += t.hours.to_f
      else
        hour_hash["Pending"] += t.hours.to_f
      end
    end
    archived_opportunities.each do |t|
      hour_hash["Completed"] += t.hours.to_f
    end
    hour_hash
  end

  begin
    def self.from_omniauth(auth)
      def password_required?
        false
      end
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info.email
        user.name = auth.info.name
      end
    rescue ActiveRecord::RecordInvalid => invalid
      if User.exists?(:email => auth.info.email)
        @user = User.find_by_email(auth.info.email)
      end
    end
  end
end
