Rails.application.routes.draw do
  namespace :api do
    resources :changes
    get "/check", to: "changes#check"
    get "/process_string", to: "reversed_strings#process_string" # URL for handling the reversal of the string
    get "/calculate_even", to: "revisions#calculate_even"
    get "/book_title", to: "books#title"
    get "/calculate_array_sum", to: "sum_arrays#calculate_array_sum", as: :calculate_array_sum # Sum of array elements
  end
end
