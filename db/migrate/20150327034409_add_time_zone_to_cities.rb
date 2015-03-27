class AddTimeZoneToCities < ActiveRecord::Migration
  def change
    add_column :cities, :time_zone, :string
  end
end
