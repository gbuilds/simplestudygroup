class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2}
  validates :description, length: { maximum: 500 }
  validates_associated :city
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :city
  
  has_many :comments, dependent: :destroy
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :attendances, dependent: :destroy
  has_many :attended_events, class_name: "Event", through: :attendances, source: :event
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  
  # Returns the joined first and last_name for a User
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  # Return the Users with a specific tag
  def self.tagged_with(name)
    Tag.find_by_name!(name.downcase.titleize).users
  end
  
  # Returns a string of the tags for a user
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  # Takes a comma-separated string and sets User tags
  def tag_list=(names)
    self.tags = names.split(", ").map do |n|
      Tag.where(name: n.strip.downcase.titleize).first_or_create!
    end
  end
end
