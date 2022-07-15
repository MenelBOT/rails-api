Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/programming_languages", to: "languages#show_many"
  get "/programming_languages/:languageID", to: "languages#show"
  post "/programming_languages", to: "languages#create"
  put "/programming_languages/:languageID", to: "languages#update"
  # Defines the root path route ("/")
  # root "articles#index"
end
