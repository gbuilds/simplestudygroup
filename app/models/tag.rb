class Tag < ActiveRecord::Base
  belongs_to :tagging, polymorphic: true
end
