# frozen_string_literal: true

class ActivityPrescriptor
  attr_reader :start_seconds, :end_seconds, :day_of_the_week, :category

  def initialize(params)
    @start_seconds = TimeFormatter.hours_minutes_to_seconds(params[:start_hour])
    @end_seconds = TimeFormatter.hours_minutes_to_seconds(params[:end_hour])
    @day_of_the_week = params[:day_of_the_week]
    @category = params[:category]
  end

  def recommend
    activities_ids = suitable_activities_by_opening_hours
    Activity.by_category(category).order_by_hours_spent.where(id: activities_ids).first
  end

  private

  def suitable_activities_by_opening_hours
    OpeningHour.includes(:activity).by_day_of_the_week(day_of_the_week).select do |oh|
      in_range?(oh.start_hour, oh.end_hour, oh.activity.hours_spent)
    end.map(&:activity_id).uniq
  end

  def in_range?(oh_start_seconds, oh_end_seconds, hours_spent)
    seconds_in_common(oh_start_seconds, oh_end_seconds) >= TimeFormatter.decimal_hours_to_seconds(hours_spent)
  end

  def seconds_in_common(oh_start_seconds, oh_end_seconds)
    ((oh_start_seconds..oh_end_seconds).to_a & (start_seconds..end_seconds).to_a).count
  end
end
