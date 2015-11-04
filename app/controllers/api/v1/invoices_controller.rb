class Api::V1::InvoicesController < ApplicationController
  def show
    respond_with Invoice.find(params[:id])
  end

  def index
    respond_with Invoice.all
  end

  def find
    respond_with Invoice.find_by(find_params)
  end

  def find_all
    respond_with Invoice.where(find_params)
  end

  def random
    respond_with Invoice.limit(1).order("RANDOM()")
  end

  def transactions
    respond_with invoice_finder.transactions
  end

  def invoice_items
    respond_with invoice_finder.invoice_items
  end

  def items
    respond_with invoice_finder.items.uniq
  end

  def customer
    respond_with invoice_finder.customer
  end

  def merchant
    respond_with invoice_finder.merchant
  end

  private

  def find_params
    params.permit(:id,
                  :invoice_id,
                  :customer_id,
                  :merchant_id,
                  :status,
                  :created_at,
                  :updated_at)
  end

  def invoice_finder
    Invoice.find(find_params[:invoice_id])
  end
end