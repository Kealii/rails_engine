Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :customers, only: [:show, :index] do
        get :invoices
        get :transactions
        get :favorite_merchant

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoices, only: [:show, :index] do
        get :transactions
        get :invoice_items
        get :items
        get :customer
        get :merchant

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
        get :best_day

        collection do
          get :find
          get :find_all
          get :random
          get :most_revenue
          get :most_items
        end
      end

      resources :merchants, only: [:show, :index] do
        get :items
        get :invoices
        get :revenue
        get :favorite_customer
        get :customers_with_pending_invoices

        collection do
          get :find
          get :find_all
          get :random
          get :most_revenue
          get :most_items
          get :revenue, action: :revenue_by_date
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
