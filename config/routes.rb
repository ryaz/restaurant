Restaurant::Application.routes.draw do
  resources :reservations
  root 'reservations#index'
end
