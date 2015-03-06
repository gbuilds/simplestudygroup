class Event < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10, maximum: 140 }
  validates :description, presence: true, length: { minimum: 140, maximum: 1000 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  belongs_to :city
  belongs_to :creator, class_name: "User"
  
  has_many :comments
  has_many :attendances
  has_many :attendees, class_name: "User", through: :attendances, source: :event
end
