# frozen_string_literal: true

class AddPrivateToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :is_private, :boolean, default: true, null: false
  end
end
