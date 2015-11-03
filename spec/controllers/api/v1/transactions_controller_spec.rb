require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  let(:transaction) { Transaction.create(invoice_id: 1,
                                         credit_card_number: "2",
                                         credit_card_expiration_date: "3",
                                         result: "success") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: transaction.id, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the correct invoice" do
      get :show, id: transaction.id, format: :json
      expect(json_response["result"]).to eq transaction.result
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the right number of invoices" do
      number_of_transactions = Transaction.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_transactions
    end
  end

end
