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

require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe '#search' do
    before do
      create(:activity, category: 'shopping', district: 'Centro', location: 'outdoors')
      create(:activity, category: 'cultural', district: 'Latina', location: 'indoors')
    end

    it 'searches by category' do
      expect(described_class.search(category: 'shopping').count).to eq 1
      expect(described_class.search(category: 'cultural').count).to eq 1
      expect(described_class.search(category: 'nature').count).to eq 0
    end

    it 'searches by district' do
      expect(described_class.search(district: 'centro').count).to eq 1
      expect(described_class.search(district: 'Latina').count).to eq 1
      expect(described_class.search(district: 'Retiro').count).to eq 0
    end

    it 'searches by location' do
      expect(described_class.search(location: 'outdoors').count).to eq 1
      expect(described_class.search(location: 'indoors').count).to eq 1
    end

    it 'searches by category, district and location' do
      create(:activity, category: 'cultural', district: 'Centro', location: 'indoors')
      expect(described_class.search(location: 'outdoors', district: 'Centro', category: 'shopping').count).to eq 1
      expect(described_class.search(location: 'indoors', category: 'cultural').count).to eq 2
    end
  end

  describe 'validations' do
    it 'is invalid if name-category-location-district are the same as a previous record' do
      create(:activity, name: 'Teatros del Canal', category: 'cultural', location: 'indoors', district: 'Chamberí')
      new_activity = build(:activity, name: 'Teatros del Canal', category: 'cultural', location: 'indoors', district: 'Chamberí')
      expect(new_activity).not_to be_valid
    end

    it 'is valid if one of these name-category-location-district is different than another previous record' do
      create(:activity, name: 'Teatros del Canal', category: 'cultural', location: 'indoors', district: 'Chamberí')
      new_activity = build(:activity, name: 'Teatros del Canal', category: 'cultural', location: 'indoors', district: 'Latina')
      expect(new_activity).to be_valid
    end
  end
end
