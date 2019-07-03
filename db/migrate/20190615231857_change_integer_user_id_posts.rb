class ChangeIntegerUserIdPosts < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :user_id, :integer
    change_column :members, :talk_id, :integer
  end
end
