class Api::V1::MerchantsController < ApplicationController
  def show
    respond_with Merchant.find(params[:id])
  end

  def index
    respond_with Merchant.all
  end
end
