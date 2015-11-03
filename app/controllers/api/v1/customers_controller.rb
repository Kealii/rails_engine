class Api::V1::CustomersController < ApplicationController
  def show
    respond_with Customer.find(params[:id])
  end

  def index
    respond_with Customer.all
  end
end
