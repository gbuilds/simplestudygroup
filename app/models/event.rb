class Event < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  belongs_to :city
  belongs_to :creator, class_name: "User"
  
  has_many :comments
  has_many :attendances
  has_many :attendees, class_name: "User", through: :attendances, source: :user
  has_many :tags, as: :taggings
end
