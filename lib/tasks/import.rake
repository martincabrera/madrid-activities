# frozen_string_literal: true

namespace :import do
  desc 'TODO'
  task :json_file, [:json_content] => :environment do |_, args|
    
    if args.key?(:json_content) && !args[:json_content].nil?
      activity_list = args[:json_content]
    else
      activity_list = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'json', 'madrid.json')))
    end

    activity_list.each do |activity|
      latlng = activity['latlng']
      activity_object = Activity.create(activity.except('opening_hours', 'latlng').merge('latitude' => latlng[0], 'longitude' => latlng[1]))
      activity["opening_hours"].each do |day_of_the_week, hour_ranges|
        next if hour_ranges.empty?
        hour_ranges.each do |hour_range|
          start_hour, end_hour = hour_range.split('-')
          OpeningHour.create(activity_id: activity_object.id,
                             day_of_the_week: day_of_the_week,
                             start_hour: TimeFormatter.hours_minutes_to_seconds(start_hour),
                             end_hour: TimeFormatter.hours_minutes_to_seconds(end_hour))
        end

      end
    end
  end
end


