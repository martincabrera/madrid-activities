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

FactoryBot.define do
  factory :opening_hour do
    activity { nil }
    day_of_the_week { 'mo' }
    start_hour { 57_600 }
    end_hour { 72_000 }
  end
end
