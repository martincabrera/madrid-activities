# frozen_string_literal: true

unless @recommendation.nil?
  json.properties do
    json.name @recommendation.name
    json.category @recommendation.category
    json.location @recommendation.location
    json.district @recommendation.district
    json.opening_hours @recommendation.opening_hours do |opening_hour|
      json.day opening_hour.day_of_the_week
      json.start_hour TimeFormatter.seconds_to_hours_minutes(opening_hour.start_hour)
      json.end_hour TimeFormatter.seconds_to_hours_minutes(opening_hour.end_hour)
    end
  end
  json.geometry do
    json.type 'Point'
    json.coordinates [@recommendation.longitude, @recommendation.latitude]
  end
end
