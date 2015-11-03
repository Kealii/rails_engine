class Api::V1::ItemsController < ApplicationController
  def show
    respond_with Item.find(params[:id])
  end

  def index
    respond_with Item.all
  end
end
