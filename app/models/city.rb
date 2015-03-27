class City < ActiveRecord::Base
  has_many :users
  has_many :events
  
  validates :time_zone, 
  inclusion: {
    in: ActiveSupport::TimeZone.zones_map.keys
    }
end
