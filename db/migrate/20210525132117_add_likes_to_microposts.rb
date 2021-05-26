class AddLikesToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :likes, :integer, default: 0
    add_column :microposts, :liked_at, :datetime, array: true, default: []
    add_column :microposts, :who_liked, :integer, array: true, default: []
    
  end
end
