class Event < ActiveRecord::Base
  
  belongs_to :creator, class_name: "User"
  
  has_many :comments
  has_many :attendances
  has_many :attendees, class_name: "User", through: :attendances, source: :event
end
