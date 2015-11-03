require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  let(:transaction) { Transaction.create(invoice_id: "1",
                                         credit_card_number: "1",
                                         credit_card_expiration_date: "1",
                                         result: "success") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: transaction.id, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

end
