class AddStatusToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :status, :boolean, default: false
  end
end
