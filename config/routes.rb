Site::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'home#index'
  match '/:station_id/' => 'home#stop_times', as: :station, via: [:get]
end
