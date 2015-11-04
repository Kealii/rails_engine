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

  private

  def find_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price)
  end
end
