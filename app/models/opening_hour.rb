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
#  index_opening_hours_on_activity_id  (activity_id)
#  index_opening_hours_on_end_hour     (end_hour)
#  index_opening_hours_on_start_hour   (start_hour)
#

class OpeningHour < ApplicationRecord
  belongs_to :activity
end
