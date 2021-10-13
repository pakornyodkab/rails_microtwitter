Rails.application.routes.draw do
  get 'system/register'
  get 'system/feed'
  get 'system/new_post'
  get 'system/profile'
  get 'system/main'
  resources :follows
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
