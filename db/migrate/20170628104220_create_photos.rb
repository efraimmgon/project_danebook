class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false

      t.timestamps
    end
    add_attachment :photos, :asset
    add_index :photos, :user_id
  end
end
