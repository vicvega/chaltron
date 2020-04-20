Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'chaltron/omniauth_callbacks'
  }

  resources :users, controller: 'chaltron/users' do
    collection do
      get   'self_show'
      get   'self_edit'
      patch 'self_update'
    end
    member do
      get 'enable'
      get 'disable'
    end
  end

  resources :logs, controller: 'chaltron/logs', only: [:index, :show]

  # search and create LDAP users
  if Devise.omniauth_providers.include?(:ldap) and !Chaltron.ldap_allow_all
    get   'ldap/search'       => 'chaltron/ldap#search'
    post  'ldap/multi_new'    => 'chaltron/ldap#multi_new'
    post  'ldap/multi_create' => 'chaltron/ldap#multi_create'
  end
end if defined?(Devise)
