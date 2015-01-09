Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'chaltron/omniauth_callbacks' }
  resources :users, controller: 'chaltron/users' do
    collection do
      get   'self_show'
      get   'self_edit'
      patch 'self_update'
      get   'ldap_search'
      post  'ldap_new'
      post  'ldap_create'
    end
  end
end
