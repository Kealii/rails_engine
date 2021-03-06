class Api::V1::MerchantsController < ApplicationController
  def show
    respond_with Merchant.find(params[:id])
  end

  def index
    respond_with Merchant.all
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.limit(1).order("RANDOM()")
  end

  def items
    respond_with Merchant.find(find_params[:merchant_id]).items
  end

  def invoices
    respond_with Merchant.find(find_params[:merchant_id]).invoices
  end

  def most_revenue
    respond_with Merchant.revenue_ranking(find_params[:quantity])
  end

  def most_items
    respond_with Merchant.item_ranking(find_params[:quantity])
  end

  def revenue
    respond_with Merchant.find(find_params[:merchant_id]).revenue(find_params)
  end

  def revenue_by_date
    respond_with Merchant.total_revenue_by_date(find_params[:date])
  end

  def favorite_customer
    respond_with Merchant.find(find_params[:merchant_id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(find_params[:merchant_id]).pending_invoices
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :merchant_id,
                  :created_at,
                  :updated_at,
                  :quantity,
                  :date)
  end
end
