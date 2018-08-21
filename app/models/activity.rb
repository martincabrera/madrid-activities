# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  category    :string
#  district    :string
#  hours_spent :decimal(4, 2)
#  latitude    :decimal(10, 6)
#  location    :string
#  longitude   :decimal(10, 6)
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_activities_on_category  (category)
#  index_activities_on_district  (district)
#  index_activities_on_location  (location)
#

class Activity < ApplicationRecord
  has_many :opening_hours, dependent: :destroy
end
