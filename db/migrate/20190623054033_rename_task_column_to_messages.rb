class RenameTaskColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :task_id, :talk_id
  end
end
