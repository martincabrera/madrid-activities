# frozen_string_literal: true

class TimeFormatter
  def self.hours_minutes_to_seconds(hours_minutes)
    h, m = hours_minutes.split(':').map(&:to_i)
    ((h * 60) + m) * 60
  end

  def self.seconds_to_hours_minutes(seconds)
    Time.at(seconds).utc.strftime('%H:%M')
  end
end
