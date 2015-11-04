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

  private

  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status)
  end
end
