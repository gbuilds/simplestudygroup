class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :events, :through => :taggings, :source => :taggable, :source_type => "Event"
  has_many :users, :through => :taggings, :source => :taggable, :source_type => "User"
end
