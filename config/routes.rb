Rails.application.routes.draw do
  namespace :api do
    resources :changes
    get "/check", to: "changes#check"
    get "/process_string", to: "reversed_strings#process_string" # URL for handling the reversal of the string
  end
end
