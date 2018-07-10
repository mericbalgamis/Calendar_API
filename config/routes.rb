Rails.application.routes.draw do
  get "/", to: "calendars#index"
  resources :calendars
  get '/calendars/search/:keyword', to: "calendars#search_with_keyword"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
