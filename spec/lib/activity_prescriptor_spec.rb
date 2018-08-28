# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe ActivityPrescriptor do
  let(:first_activity) do
    create(:activity, category: 'shopping', district: 'Centro', location: 'outdoors',
                      name: 'El Rastro', hours_spent: 1.5)
  end
  let(:second_activity) do
    create(:activity, category: 'shopping', district: 'Latina', location: 'indoors',
                      name: 'Latina museum', hours_spent: 1)
  end

  context 'when there are 2 activities with opening hours in users time range' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
      create(:opening_hour, activity: second_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
    end

    it 'returns the one with more hours spent' do
      params = { start_hour: '19:00', end_hour: '20:30', day_of_the_week: 'mo', category: 'shopping' }
      expect(described_class.new(params).recommend).to eq first_activity
    end
  end

  context 'when there is 1 activity with opening hours in users time range' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
      create(:opening_hour, activity: second_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
    end

    it 'returns the one' do
      params = { start_hour: '19:00', end_hour: '22:00', day_of_the_week: 'mo', category: 'shopping' }
      expect(described_class.new(params).recommend).to eq second_activity
    end
  end

  context 'when there are no activities with opening hours in users time range' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
      create(:opening_hour, activity: second_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
    end

    it 'returns nothing' do
      params = { start_hour: '10:00', end_hour: '14:00', day_of_the_week: 'mo', category: 'shopping' }
      expect(described_class.new(params).recommend).to be_nil
    end
  end

  context 'when there are 2 activities with opening hours in users time range BUT different category' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
      create(:opening_hour, activity: second_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:30'), day_of_the_week: 'mo')
    end

    it 'returns nothing' do
      params = { start_hour: '19:00', end_hour: '20:30', day_of_the_week: 'mo', category: 'cultural' }
      expect(described_class.new(params).recommend).to be_nil
    end
  end

  context 'when there is 1 activity with 2 opening hours in users time range' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('10:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('14:00'), day_of_the_week: 'mo')
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
    end

    it 'returns the activity' do
      params = { start_hour: '10:00', end_hour: '20:00', day_of_the_week: 'mo', category: 'shopping' }
      expect(described_class.new(params).recommend).to eq first_activity
    end
  end

  context 'when there is 1 activity with 2 opening hours in users time range but with not enough time to complete the visit' do
    before do
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('10:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('14:00'), day_of_the_week: 'mo')
      create(:opening_hour, activity: first_activity, start_hour: TimeFormatter.hours_minutes_to_seconds('16:00'),
                            end_hour: TimeFormatter.hours_minutes_to_seconds('20:00'), day_of_the_week: 'mo')
    end

    it 'returns nothing' do
      params = { start_hour: '13:00', end_hour: '17:00', day_of_the_week: 'mo', category: 'shopping' }
      expect(described_class.new(params).recommend).to be_nil
    end
  end
end
