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

require 'rails_helper'

RSpec.describe OpeningHour, type: :model do
  describe 'scope by_day_of_the_week' do
    before do
      activity = create(:activity)
      create(:opening_hour, activity: activity, start_hour: TimeFormatter.hours_minutes_to_seconds('17:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('19:00'), day_of_the_week: 'mo')
      create(:opening_hour, activity: activity, start_hour: TimeFormatter.hours_minutes_to_seconds('17:30'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('19:30'), day_of_the_week: 'mo')
    end

    context 'when there are records by one day' do
      it 'finds all records' do
        expect(described_class.by_day_of_the_week('mo').count).to eq 2
      end
    end

    context 'when there are no records by one specific day' do
      it 'finds all records' do
        expect(described_class.by_day_of_the_week('tu').count).to be_zero
      end
    end
  end
end
