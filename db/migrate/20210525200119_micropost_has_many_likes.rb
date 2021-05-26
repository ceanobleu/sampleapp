class MicropostHasManyLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :microposts, :likes, :integer, default: 0
    remove_column :microposts, :liked_at, :datetime, array: true, default: []
    remove_column :microposts, :who_liked, :integer, array: true, default: []
  
    create_table :likes do |t|
      t.references :micropost, null: false, foreign_key: true
      t.timestamps
    end
    # add_index :likes, [:micropost_id, :liked_at]
  end
end
