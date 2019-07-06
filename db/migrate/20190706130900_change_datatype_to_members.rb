class ChangeDatatypeToMembers < ActiveRecord::Migration[5.2]
  def change
      change_column :members, :user_id, :integer
      change_column :members, :talk_id, :integer

  end
end
