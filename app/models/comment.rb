class Comment < ActiveRecord::Base
  validates :body, presence: true, length: { minimum: 2, maximum: 200 }
  
  belongs_to :user
  belongs_to :event
end
