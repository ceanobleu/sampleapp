class AddUserIdToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :user_id, :integer
    remove_column :likes, :updated_at
  end
end
