Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers,     only: [:show, :index]
      resources :invoices,      only: [:show, :index]
      resources :invoice_items, only: [:show, :index]
      resources :items,         only: [:show, :index]
      resources :merchants,     only: [:show, :index]
      resources :transactions,  only: [:show, :index]
    end
  end
end
