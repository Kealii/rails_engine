class Api::V1::InvoicesController < ApplicationController
  def show
    respond_with Invoice.find(params[:id])
  end

  def index
    respond_with Invoice.all
  end
end
