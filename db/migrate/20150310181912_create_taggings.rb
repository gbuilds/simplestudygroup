class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id, index: true
      t.integer :taggable_id, index: true
      t.string  :taggable_type, index: true
      t.timestamps null: false
    end
  end
end