# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
      # GET /activities
      def index
        @activities = Activity.search(params)
      end
    end
  end
end
