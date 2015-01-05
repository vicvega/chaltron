Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'chaltron/omniauth_callbacks' }
  resources :users, controller: 'chaltron/users' do
    collection do
      get   'self_show',   as: :self_show
      get   'self_edit',   as: :self_edit
      patch 'self_update', as: :self_update
    end
  end
  get   'self_show'   => 'chaltron/users#self_show',   as: :self_show
  get   'self_edit'   => 'chaltron/users#self_edit',   as: :self_edit
  patch 'self_update' => 'chaltron/users#self_update', as: :self_update
end
