# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
      before_action :enforce_all_params, only: [:recommendation]
      def index
        @activities = Activity.search(params)
      end

      def recommendation
        @recommendation = ActivityPrescriptor.new(params).recommend
      end

      private

      def enforce_all_params
        return unless missing_params?
        render_error(:unprocessable_entity,
                     status: 422,
                     name: 'Unprocessable Entity',
                     message: 'We could not complete your request')
      end

      def missing_params?
        %w[start_hour end_hour category day_of_the_week].any? { |param| params.dig(param).nil? }
      end
    end
  end
end
