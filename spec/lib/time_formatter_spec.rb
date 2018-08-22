# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe TimeFormatter do
  let(:hours_minutes) { '16:34' }
  let(:number_of_seconds) { 59_640 }

  context 'when an hh:mm is provided' do
    it 'returns the right amount of seconds' do
      expect(described_class.hours_minutes_to_seconds(hours_minutes)).to eq number_of_seconds
    end
  end

  context 'when a number of seconds is provided' do
    it 'returns the right hh:mm' do
      expect(described_class.seconds_to_hours_minutes(number_of_seconds)).to eq hours_minutes
    end
  end
end
