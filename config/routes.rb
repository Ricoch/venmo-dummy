Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  ExceptionHunter.routes(self)

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get :status, to: 'api#status'

      resources :users, only: %i[update show]

      resources :settings, only: [] do
        get :must_update, on: :collection
      end
    end
  end
end
