Site::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'home#index'
  match '/:direction/' => 'home#stops', via: [:get]
  # match '/:station/' => 'home#stop_times', as: :station, via: [:get]
  match '/:station/trip/:trip' => 'home#trip_details', as: :trip, via: [:get]
end
