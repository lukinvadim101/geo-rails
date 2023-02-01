class AddLocationRefToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :locations, :user_id, :integer
    add_reference :locations, :user, foreign_key: true
  end
end
