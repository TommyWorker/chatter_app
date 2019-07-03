class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :talk_id
      t.string :user_id

      t.timestamps
    end
  end
end
