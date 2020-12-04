Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations',
  }
  devise_scope :user do
    get '/users/:id/edit_password', to: 'registrations#edit_password', as: 'edit_password'
    patch '/users/:id/update_password', to: 'registrations#update_password', as: 'update_password'
  end

  root 'static_pages#home'
  get :about, to: 'static_pages#about'
  get :terms, to: 'static_pages#terms'
  get :likes, to: 'likes#index'
  resources :users, only: [:index, :show]
  resources :groups, only: [:new, :create, :destroy, :edit, :update] do
    resources :posts, only: [:index, :show, :create, :destroy, :edit, :update] do
      resources :likes, only: [:create, :destroy]
    end
  end
end
