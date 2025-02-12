# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :auth_callback
    delete '/logout', to: 'auth#logout'

    resources :bulletins, only: %i[index show new create edit update] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    resource :profile, only: :show, controller: :profile

    namespace 'admin' do
      get '/', to: 'bulletins#index'

      resources :categories, only: %i[index new create edit update destroy]

      resources :bulletins, only: [:index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
    end
  end
end
