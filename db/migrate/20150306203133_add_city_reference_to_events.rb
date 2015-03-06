class AddCityReferenceToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :city, index: true
    add_foreign_key :events, :cities
  end
end
