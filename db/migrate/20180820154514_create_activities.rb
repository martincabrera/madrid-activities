# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.decimal :hours_spent, precision: 4, scale: 2
      t.string :category
      t.string :location
      t.string :district
      t.decimal :latitude, precision: 11, scale: 7
      t.decimal :longitude, precision: 11, scale: 7

      t.timestamps
    end
    add_index(:activities, :category)
    add_index(:activities, :location)
    add_index(:activities, :district)
  end
end
