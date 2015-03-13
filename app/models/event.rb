class Event < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_associated :city
  
  belongs_to :city
  belongs_to :creator, class_name: "User"
  
  has_many :comments, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attendees, class_name: "User", through: :attendances, source: :user
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  
  
  # Return the Events with a specific tag
  def self.tagged_with(name)
    Tag.find_by_name!(name.downcase).events
  end
  
  # Returns a string of the tags for an event
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  # Takes a comma-separated string and sets Event tags
  def tag_list=(names)
    self.tags = names.split(", ").map do |n|
      Tag.where(name: n.strip.downcase).first_or_create!
    end
  end
  
end
