# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

describe 'import:json_file' do # rubocop:disable RSpec/DescribeClass
  require 'rake'
  CartoTask::Application.load_tasks



  it 'creates Activity objects based on json seeds' do
      expect do
        Rake::Task['import:json_file'].invoke(json_data)
      end.to change(Activity, :count).by(2)
  end


  def json_data
    [
    {
        "name": "El Rastro",
        "opening_hours": {
            "mo": [],
            "tu": [],
            "we": [],
            "th": [],
            "fr": [],
            "sa": [],
            "su": ["09:00-15:00"]
        },
        "hours_spent": 2.5,
        "category": "shopping",
        "location": "outdoors",
        "district": "Centro",
        "latlng": [40.4087357,-3.7081466]
    }.with_indifferent_access,
    {
        "name": "Palacio Real",
        "opening_hours": {
            "mo": ["10:00-20:00"],
            "tu": ["10:00-20:00"],
            "we": ["10:00-20:00"],
            "th": ["10:00-20:00"],
            "fr": ["10:00-20:00"],
            "sa": ["10:00-20:00"],
            "su": ["10:00-20:00"]
        },
        "hours_spent": 1.5,
        "category": "cultural",
        "location": "outdoors",
        "district": "Centro",
        "latlng": [40.4173423,-3.7144063]
    }.with_indifferent_access
    ]
  end
end