class CreateFriendshipRequests < ActiveRecord::Migration
  def change
    create_table :friendship_requests do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.string :status

      t.timestamps null: false
    end
  end
end
