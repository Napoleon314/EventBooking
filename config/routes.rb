Rails.application.routes.draw do
  get 'events/index'

  get     'index',              to: 'static_pages#index'
  get     'home',               to: 'static_pages#home'
  get     'about',              to: 'static_pages#about'

  get     'profile',            to: 'users#profile' 
  get     'signup',             to: 'users#new'
  post    'signup',             to: 'users#create'
  get     'settings',           to: 'users#edit'
  patch   'signup',             to: 'users#update'

  get     'signin',             to: 'sessions#new'
  post    'signin',             to: 'sessions#create'
  delete  'session',            to: 'sessions#destroy'

  get     'owned_events',       to: 'events#owned'
  get     'booked_events',      to: 'events#booked'

  root    'static_pages#index'

  resources :events do
    resources :books
  end

end
