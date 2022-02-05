Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    resources :contacts
    post "/user/signup", to: "users#create"
    post "/user/signin", to: "users#signin"
  end
end
