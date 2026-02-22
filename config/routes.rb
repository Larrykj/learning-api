Rails.application.routes.draw do
  namespace :api do
    resources :changes
    resources :articles
    resources :revisions

    get "check", to: "changes#check"
    get "reverse", to: "changes#reverse"
    get "convert", to: "changes#convert"
    get "calculate_even", to: "revisions#calculate_even"
    get "book_title", to: "books#title"

    root to: "articles#index"
  end
end
