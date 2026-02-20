Rails.application.routes.draw do
  namespace :api do
    resources :changes
    get "/check", to: "changess#check"
  end
end
