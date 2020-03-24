Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'chaltron/omniauth_callbacks',
    sessions: 'chaltron/sessions'
  }

 resources :logs, controller: 'chaltron/logs', only: [:index, :show]
end
