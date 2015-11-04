class Api::V1::InvoiceItemsController < ApplicationController
  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def index
    respond_with InvoiceItem.all
  end

  def find
    respond_with InvoiceItem.find_by(find_params)
  end

  def find_all
    respond_with InvoiceItem.where(find_params)
  end

  def random
    respond_with InvoiceItem.limit(1).order("RANDOM()")
  end

  def invoice
    respond_with InvoiceItem.find(find_params[:invoice_item_id]).invoice
  end

  def item
    respond_with InvoiceItem.find(find_params[:invoice_item_id]).item
  end

  private

  def find_params
    params.permit(:id,
                  :item_id,
                  :invoice_id,
                  :invoice_item_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at)
  end
end
