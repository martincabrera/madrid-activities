# frozen_string_literal: true

json.type 'FeatureCollection'
json.features @activities do |activity|
  json.type 'Feature'
  json.properties do
    json.name activity.name
    json.category activity.category
    json.location activity.location
    json.district activity.district
    opening_hours = ''
    activity.opening_hours.each do |opening_hour|
      opening_hours += opening_hour.day_of_the_week + ': ' + TimeFormatter.seconds_to_hours_minutes(opening_hour.start_hour) + '-' + TimeFormatter.seconds_to_hours_minutes(opening_hour.end_hour) + "<br />"
    end
    json.opening_hours opening_hours
  end
  json.geometry do
    json.type 'Point'
    json.coordinates [activity.longitude.to_f, activity.latitude.to_f]
  end
end
