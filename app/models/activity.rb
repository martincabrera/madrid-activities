# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  category    :string
#  district    :string
#  hours_spent :decimal(4, 2)
#  latitude    :decimal(11, 7)
#  location    :string
#  longitude   :decimal(11, 7)
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
  # associations
  has_many :opening_hours, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :category, presence: true
  validates :location, presence: true
  validates :district, presence: true
  validates_uniqueness_of :name, scope: %i[category location district]

  def self.search(params)
    scope = unscoped
    scope = category_search(scope, params)
    scope = location_search(scope, params)
    district_search(scope, params)
  end

  def self.category_search(scope, params)
    return scope unless params.dig(:category)
    scope.where('lower(category) = ?', params[:category].downcase)
  end

  def self.location_search(scope, params)
    return scope unless params.dig(:location)
    scope.where('lower(location) = ?', params[:location].downcase)
  end

  def self.district_search(scope, params)
    return scope unless params.dig(:district)
    scope.where('lower(district) = ?', params[:district].downcase)
  end
end
