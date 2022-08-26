Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/dealerships', to: 'dealerships#index'
  post '/dealerships', to: 'dealerships#create'
  get '/dealerships/new', to: 'dealerships#new'
  get '/dealerships/:id', to: 'dealerships#show'
  get '/dealerships/:id/edit', to: 'dealerships#edit'
  patch '/dealerships/:id', to: 'dealerships#update'
  get '/dealerships/:id/vehicles', to: 'dealership_vehicles#index'
  get '/dealerships/:id/vehicles/new', to: 'dealership_vehicles#new'
  post '/dealerships/:id/vehicles', to: 'dealership_vehicles#create'

  get '/vehicles', to: 'vehicles#index'
  get '/vehicles/:id', to: 'vehicles#show'
end
