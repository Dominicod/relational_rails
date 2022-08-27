Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/dealerships', to: 'dealerships#index'
  post '/dealerships', to: 'dealerships#create'
  get '/dealerships/new', to: 'dealerships#new'
  get '/dealerships/:id', to: 'dealerships#show'
  delete '/dealerships/:id', to: 'dealerships#destroy'
  get '/dealerships/:id/edit', to: 'dealerships#edit'
  patch '/dealerships/:id', to: 'dealerships#update'

  get '/dealerships/:id/vehicles', to: 'dealership_vehicles#index'
  get '/dealerships/:id/vehicles/new', to: 'dealership_vehicles#new'
  post '/dealerships/:id/vehicles', to: 'dealership_vehicles#create'
  patch '/dealerships/:id/vehicles', to: 'dealership_vehicles#index'
  get '/dealerships/:id/:alphabetical/vehicles', to: 'dealership_vehicles#index'

  get '/vehicles', to: 'vehicles#index'
  get '/vehicles/:id', to: 'vehicles#show'
  delete '/vehicles/:id', to: 'vehicles#destroy'
  get '/vehicles/:id/edit', to: 'vehicles#edit'
  patch '/vehicles/:id', to: 'vehicles#update'
end
