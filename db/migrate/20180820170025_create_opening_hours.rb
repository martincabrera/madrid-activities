# frozen_string_literal: true

class CreateOpeningHours < ActiveRecord::Migration[5.2]
  def change
    create_table :opening_hours do |t|
      t.references :activity, foreign_key: true
      t.string :day_of_the_week
      t.integer :start_hour
      t.integer :end_hour

      t.timestamps
    end
    add_index(:opening_hours, :start_hour)
    add_index(:opening_hours, :end_hour)
  end
end
