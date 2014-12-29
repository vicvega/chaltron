Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'chaltron/omniauth_callbacks' }
  resources :users, controller: 'chaltron/users'
end
