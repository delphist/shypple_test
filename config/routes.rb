# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resource :sailings, only: [] do
      get :cheapest_direct
      get :cheapest_indirect
    end
  end
end
