Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/password', to: 'registrations#edit_password'
    patch '/users/password/edit', to: 'registrations#update_password'
  end

  root 'static_pages#home'
  get :about, to: 'static_pages#about'
  get :terms, to: 'static_pages#terms'
  resources :users, only: [:show]
end
