class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2}
  validates :description, length: { maximum: 500 }
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
  
  has_many :sent_frequests, class_name: "FriendshipRequest", foreign_key: "sender_id"
  has_many :received_frequests, class_name: "FriendshipRequest", foreign_key: "receiver_id"
  
  has_many :friendships, foreign_key: "user_id", class_name: "Friendship"
  has_many :friends, through: :friendships
  
  
  # Returns the joined first and last_name for a User
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  # Return the Users with a specific tag
  def self.tagged_with(name)
    Tag.find_by(name: name.downcase).users
  end
  
  # Returns a string of the tags for a user
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  # Takes a comma-separated string and sets User tags
  def tag_list=(names)
    self.tags = names.split(", ").map do |n|
      Tag.where(name: n.strip.downcase).first_or_create!
    end
  end
  
  # Register for an event
  def register(event)
    attended_events << event
  end
  
  # Return true if user doesn't have any current tags/interests
  def no_tags?
    self.tags.blank?
  end
  
  # Send a friendship request to another user
  def send_friendship_request(user)
    self.sent_frequests.create(sender_id: self.id, receiver_id: user.id, status: "pending")
  end
  
  # Set up friendship and complementary-opposite friendship for user and friend
  def build_friendships(user)
    Friendship.create(user_id: self.id, friend_id: user.id)
    Friendship.create(user_id: user.id, friend_id: self.id)
  end
  
  # Return true if other user is friend
  def friends?(other_user)
    self.friends.include? other_user
  end
  
  def pending_frequests
    self.received_frequests.select { |r| r.status == "pending"}
    # self.received_frequests.where(status: "pending")
  end
  
  # all friend requests sent and received
  def all_frequests
    self.received_frequests + self.sent_frequests
  end
  
  # Returns a user's feed
  def feed
    # creator id is within user.friends' ids
    ids = self.friends.map { |f| f.id }
    ids << self.id
    Event.where({ creator_id: ids })
  end
end
