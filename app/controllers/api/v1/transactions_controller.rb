class Api::V1::TransactionsController < ApplicationController
  def show
    respond_with Transaction.find(params[:id])
  end

  def index
    respond_with Transaction.all
  end
end
