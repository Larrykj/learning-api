Rails.application.routes.draw do
  namespace :api do
    resources :changes
    get "/check", to: "changes#check"
  end
end
