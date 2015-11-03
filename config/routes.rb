Rails.application.routes.draw do
  namespace :api do
  namespace :v1 do
    get 'items/show'
    end
  end

  namespace :api do
  namespace :v1 do
    get 'items/index'
    end
  end

  namespace :api do
  namespace :v1 do
    get 'invoice_items/show'
    end
  end

  namespace :api do
  namespace :v1 do
    get 'invoice_items/index'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :customers,     defaults: { format: :json }, only: [:show, :index]
      resources :invoices,      defaults: { format: :json }, only: [:show, :index]
      resources :invoice_items, defaults: { format: :json }, only: [:show, :index]
      resources :items,         defaults: { format: :json }, only: [:show, :index]
      resources :merchants,     defaults: { format: :json }, only: [:show, :index]
      resources :transactions,  defaults: { format: :json }, only: [:show, :index]
    end
  end
end
