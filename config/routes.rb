Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/programming_languages", to: "languages#show_many"

  # Defines the root path route ("/")
  # root "articles#index"
end
