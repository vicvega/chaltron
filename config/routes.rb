Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'chaltron/omniauth_callbacks' }
  resources :users, controller: 'chaltron/users' do
    collection do
      get   'self_show'
      get   'self_edit'
      patch 'self_update'
    end
  end
  # search and create LDAP users
  get   'ldap/search'       => 'chaltron/ldap#search'
  get   'ldap/new'          => 'chaltron/ldap#new'
  post  'ldap/create'       => 'chaltron/ldap#create'
  post  'ldap/multi_new'    => 'chaltron/ldap#multi_new'
  post  'ldap/multi_create' => 'chaltron/ldap#multi_create'

end
