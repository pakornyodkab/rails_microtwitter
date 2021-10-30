Rails.application.routes.draw do
  resources :likes
  get '/register' ,to: "system#register" ,as:"register"
  post '/register' ,to: "system#create" ,as:"registerpost"
  get '/feed' ,to: "system#feed"
  get '/new_post' ,to: "system#new_post" ,as:"new_post_sys"
  post '/new_post' ,to: "system#createpost" ,as:"new_post_sys_vpost"
  get '/profile/:name' ,to: "system#profile" ,as:"profile_sys"
  get '/main' ,to: "system#main" ,as:"main"
  post '/main' ,to: "system#userlogin"
  get 'createfollow/:follower_id/:followee_id' ,to: "system#createfollow" ,as: "createfollow_sys"
  get 'destroyfollow/:follower_id/:followee_id' ,to: "system#destroyfollow" ,as: "destroyfollow_sys"
  get 'createlike/:post_id/:user_id' ,to: "system#createlike" ,as:"createlike_sys"
  get 'destroylike/:post_id/:user_id' ,to: "system#destroylike" ,as:"destroylike_sys"

  resources :follows
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
