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
end
