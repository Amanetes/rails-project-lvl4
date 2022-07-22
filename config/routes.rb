# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#logout', as: :logout

    resources :repositories, only: %i[index show new create] do
      scope module: :repositories do
        resources :checks, only: %i[show create]
      end
    end
  end

  namespace :api do
    resource :checks, only: %i[create]
  end
end
