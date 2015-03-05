class Event < ActiveRecord::Base
  belongs_to :User, as: "creator"
end
