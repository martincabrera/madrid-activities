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

require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
