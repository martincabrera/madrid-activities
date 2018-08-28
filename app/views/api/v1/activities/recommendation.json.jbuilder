# frozen_string_literal: true

unless @recommendation.nil?
  json.type 'Feature'
  json.properties do
    json.name @recommendation.name
    json.category @recommendation.category
    json.location @recommendation.location
    json.district @recommendation.district
    opening_hours = ''
    @recommendation.opening_hours.each do |opening_hour|
      opening_hours += opening_hour.day_of_the_week + ': ' + TimeFormatter.seconds_to_hours_minutes(opening_hour.start_hour) + '-' + TimeFormatter.seconds_to_hours_minutes(opening_hour.end_hour) + "<br />"
    end
    json.opening_hours opening_hours
  end
  json.geometry do
    json.type 'Point'
    json.coordinates [@recommendation.longitude.to_f, @recommendation.latitude.to_f]
  end
end
