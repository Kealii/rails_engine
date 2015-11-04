Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :customers, only: [:show, :index] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoices, only: [:show, :index] do
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoice_items, only: [:show, :index] do
        get :invoice
        get :item

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :items, only: [:show, :index] do
        get :invoice_items
        get :merchant

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :merchants, only: [:show, :index] do
        get :items
        get :invoices

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :transactions, only: [:show, :index] do
        get :invoice

        collection do
          get :find
          get :find_all
          get :random
        end
      end

    end
  end
end
