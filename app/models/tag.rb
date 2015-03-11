class Tag < ActiveRecord::Base
  before_save :capitalize_name
  
  has_many :taggings, dependent: :destroy
  has_many :events, :through => :taggings, :source => :taggable, :source_type => "Event"
  has_many :users, :through => :taggings, :source => :taggable, :source_type => "User"
  
  private
  
  def capitalize_name
    name = self.name.split.collect(&:capitalize).join(' ') if self.name && !self.name.blank?
  end
end
