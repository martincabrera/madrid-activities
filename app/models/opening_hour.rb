# frozen_string_literal: true

# == Schema Information
#
# Table name: opening_hours
#
#  id              :integer          not null, primary key
#  day_of_the_week :string
#  end_hour        :integer
#  start_hour      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  activity_id     :integer
#
# Indexes
#
#  index_opening_hours_on_activity_id      (activity_id)
#  index_opening_hours_on_day_of_the_week  (day_of_the_week)
#

class OpeningHour < ApplicationRecord
  # associations
  belongs_to :activity

  # validations
  validates :day_of_the_week, presence: true
  validates :start_hour, presence: true
  validates :end_hour, presence: true

  # scopes
  scope :by_day_of_the_week, ->(day_of_the_week) { where(day_of_the_week: day_of_the_week) }
end
