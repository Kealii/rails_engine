class Api::V1::ItemsController < ApplicationController
  def show
    respond_with Item.find(params[:id])
  end

  def index
    respond_with Item.all
  end

  def find
    respond_with Item.find_by(find_params)
  end

  def find_all
    respond_with Item.where(find_params)
  end

  def random
    respond_with Item.limit(1).order("RANDOM()")
  end

  private

  def find_params
    params.permit(:id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :created_at,
                  :updated_at)
  end
end
