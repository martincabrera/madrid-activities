# frozen_string_literal: true

json.type 'FeatureCollection'
json.features @activities do |activity|
  json.type 'Feature'
  json.properties do
    json.name activity.name
    json.category activity.category
    json.location activity.location
    json.district activity.district
    json.opening_hours activity.opening_hours do |opening_hour|
      json.day opening_hour.day_of_the_week
      json.start_hour TimeFormatter.seconds_to_hours_minutes(opening_hour.start_hour)
      json.end_hour TimeFormatter.seconds_to_hours_minutes(opening_hour.end_hour)
    end
  end
  json.geometry do
    json.type 'Point'
    json.coordinates [activity.longitude, activity.latitude]
  end
end
