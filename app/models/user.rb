class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :city
  
  has_many :comments
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :attendances
  has_many :attended_events, class_name: "Event", through: :attendances
  
  # Returns the joined first and last_name for a User
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
