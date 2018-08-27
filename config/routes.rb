# frozen_string_literal: true

Rails.application.routes.draw do
  concern :api_base do
    resources :activities, only: [:index] do
      collection do
        get 'recommendation'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      concerns :api_base
    end
  end
end
