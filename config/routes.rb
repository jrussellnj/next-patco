Site::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'home#index'
  match '/:direction/' => 'home#stops', via: [:get], :constraints => { direction: /(eastbound|westbound)/ }
  match '/:direction/:station' => 'home#stop_times', via: [:get]
  match '/:station/trip/:trip' => 'home#trip_details', as: :trip, via: [:get]

  # Legagy routing for station names only
  match '/:station/' => 'home#stop_times', via: [ :get ]
end
