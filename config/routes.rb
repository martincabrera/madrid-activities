# frozen_string_literal: true

Rails.application.routes.draw do
  concern :api_base do
    resources :activities, only: [:index]
    resource :recommendation, only: [:show]
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
