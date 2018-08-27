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

  # scopes
  scope :by_category, ->(category_name) { where('lower(category) = ?', category_name.downcase) }
  scope :by_district, ->(district_name) { where('lower(district) = ?', district_name.downcase) }
  scope :by_location, ->(location_name) { where('lower(location) = ?', location_name.downcase) }
  scope :order_by_hours_spent, -> { order(hours_spent: :desc) }

  def self.search(params)
    scope = unscoped
    scope = category_search(scope, params)
    scope = location_search(scope, params)
    district_search(scope, params)
  end

  def self.category_search(scope, params)
    return scope if params.dig(:category).nil?
    scope.by_category(params[:category])
  end

  def self.location_search(scope, params)
    return scope if params.dig(:location).nil?
    scope.by_location(params[:location])
  end

  def self.district_search(scope, params)
    return scope if params.dig(:district).nil?
    scope.by_district(params[:district])
  end
end
