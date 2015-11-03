class Api::V1::InvoiceItemsController < ApplicationController
  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def index
    respond_with InvoiceItem.all
  end
end
