# frozen_string_literal: true

class TimeFormatter
  def self.hours_minutes_to_seconds(hours_minutes)
    h, m = hours_minutes.split(':').map(&:to_i)
    ((h * 60) + m) * 60
  end

  def self.seconds_to_hours_minutes(seconds)
    Time.at(seconds).utc.strftime('%H:%M')
  end

  def self.hours_minutes_range_to_hours(start_hour_minutes, end_hour_minutes)
    start_seconds = hours_minutes_to_seconds(start_hour_minutes)
    end_seconds = hours_minutes_to_seconds(end_hour_minutes)
    (end_seconds - start_seconds) / 3600.0
  end

  def self.decimal_hours_to_seconds(hours)
    hours * 3600
  end
end
