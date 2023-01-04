# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :private_locations do |t|
      t.text :name
      t.float :latitude
      t.float :longitude
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
