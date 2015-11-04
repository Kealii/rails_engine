require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  let!(:transaction1) { Transaction.create(invoice_id:                  invoice1.id,
                                           credit_card_number:          "2",
                                           credit_card_expiration_date: "3",
                                           result:                      "success") }

  let!(:transaction2) { Transaction.create(invoice_id:                  invoice1.id,
                                           credit_card_number:          "2",
                                           credit_card_expiration_date: "3",
                                           result:                      "success") }

  let!(:transaction3) { Transaction.create(invoice_id:                  invoice2.id,
                                           credit_card_number:          "5",
                                           credit_card_expiration_date: "6",
                                           result:                      "failed") }

  let!(:invoice1) { Invoice.create(customer_id: 1,
                                   merchant_id: 2,
                                   status:      "success") }

  let!(:invoice2) { Invoice.create(customer_id: 3,
                                   merchant_id: 4,
                                   status:      "success") }

  describe "GET #show" do
    it "returns the correct transaction" do
      get :show, id: transaction1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq transaction1.id
    end
  end

  describe "GET #index" do
    it "returns the right number of transactions" do
      number_of_transactions = Transaction.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_transactions
    end
  end

  describe "GET #find" do
    it "returns the right transaction by id" do
      get :find, id: transaction1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq transaction1.id
    end

    it "returns the right transaction by invoice id" do
      get :find, invoice_id: transaction1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["invoice_id"]).to eq transaction1.invoice_id
    end

    it "returns the right transaction by credit card number" do
      get :find, credit_card_number: transaction1.credit_card_number, format: :json

      expect(response).to have_http_status :success
      expect(json_response["credit_card_number"]).to eq transaction1.credit_card_number
    end

    it "returns the right transaction by result" do
      get :find, result: transaction1.result, format: :json

      expect(response).to have_http_status :success
      expect(json_response["result"]).to eq transaction1.result
    end
  end

  describe "GET #find_all" do
    it "returns the right transactions by id" do
      get :find_all, id: transaction1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["id"]).to eq transaction1.id
    end

    it "returns the right transactions by invoice id" do
      get :find_all, invoice_id: transaction1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["invoice_id"]).to eq transaction1.invoice_id
      expect(json_response.last["invoice_id"]).to eq transaction1.invoice_id
    end

    it "returns the right transactions by credit card number" do
      get :find_all, credit_card_number: transaction1.credit_card_number, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["credit_card_number"]).to eq transaction1.credit_card_number
      expect(json_response.last["credit_card_number"]).to eq transaction1.credit_card_number
    end

    it "returns the right transactions by result" do
      get :find_all, result: transaction1.result, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["result"]).to eq transaction1.result
      expect(json_response.last["result"]).to eq transaction1.result
    end
  end

  describe "GET #random" do
    it "returns a transaction" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #invoice" do
    it "returns an invoice from a transaction" do
      get :invoice, transaction_id: transaction1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq invoice1.id
    end
  end

end
