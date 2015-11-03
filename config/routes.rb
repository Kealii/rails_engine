Rails.application.routes.draw do

  namespace :api do
  namespace :v1 do
    get 'customers/index'
    end
  end

  namespace :api do
  namespace :v1 do
    get 'customers/show'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :customers,     default: { format: :json }, only: [:show, :index]
      resources :invoices,      default: { format: :json }, only: [:show, :index]
      resources :invoice_items, default: { format: :json }, only: [:show, :index]
      resources :items,         default: { format: :json }, only: [:show, :index]
      resources :merchants,     default: { format: :json }, only: [:show, :index]
      resources :transactions,  default: { format: :json }, only: [:show, :index]
    end
  end
end
