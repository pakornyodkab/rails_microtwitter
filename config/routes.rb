Rails.application.routes.draw do
  get '/register' ,to: "system#register" ,as:"register"
  post '/register' ,to: "system#create" ,as:"registerpost"
  get '/feed' ,to: "system#feed"
  get '/new_post' ,to: "system#new_post" ,as:"new_post_sys"
  get '/profile/:name' ,to: "system#profile" ,as:"profile_sys"
  get '/main' ,to: "system#main" ,as:"main"
  post '/main' ,to: "system#userlogin"
  get 'createfollow/:follower_id/:followee_id' ,to: "system#createfollow" ,as: "createfollow_sys"
  get 'destroyfollow/:follower_id/:followee_id' ,to: "system#destroyfollow" ,as: "destroyfollow_sys"

  resources :follows
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
