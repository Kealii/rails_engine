class Api::V1::CustomersController < ApplicationController
  def show
    respond_with Customer.find(params[:id])
  end

  def index
    respond_with Customer.all
  end

  def find
    respond_with Customer.find_by(find_params)
  end

  def find_all
    respond_with Customer.where(find_params)
  end

  def random
    respond_with Customer.limit(1).order("RANDOM()")
  end

  private

  def find_params
    params.permit(:id, :first_name, :last_name)
  end
end
