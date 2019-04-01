Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'chaltron/omniauth_callbacks',
    sessions: 'chaltron/sessions'
  }

  resources :users, controller: 'chaltron/users' do
    collection do
      get   'self_show'
      get   'self_edit'
      patch 'self_update'
    end
  end

  resources :logs, controller: 'chaltron/logs', only: [:index, :show]

  # search and create LDAP users
  if Devise.omniauth_providers.include?(:ldap) and !Chaltron.ldap_allow_all
    get   'ldap/search'       => 'chaltron/ldap#search'
    post  'ldap/multi_new'    => 'chaltron/ldap#multi_new'
    post  'ldap/multi_create' => 'chaltron/ldap#multi_create'
  end
end
