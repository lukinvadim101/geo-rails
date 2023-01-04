# frozen_string_literal: true

class AddNullOptionsToLocations < ActiveRecord::Migration[7.0]
  def change
    change_column(:locations, :latitude,  :float,  null: false)
    change_column(:locations, :longitude, :float,  null: false)
    change_column(:locations, :name,      :string, null: false)
  end
end
