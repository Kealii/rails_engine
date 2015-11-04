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

  private

  def find_params
    params.permit(:id, :name)
  end
end
