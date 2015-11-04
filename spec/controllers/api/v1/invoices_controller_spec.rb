require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  let!(:customer1) { Customer.create(first_name: "Test",
                                    last_name: "Customer") }

  let!(:customer2) { Customer.create(first_name: "Test 2",
                                     last_name: "Customer 2") }

  let!(:merchant1) { Merchant.create(name: "Test Merchant") }
  let!(:merchant2) { Merchant.create(name: "Test Merchant 2") }

  let!(:invoice1) { Invoice.create(customer_id: customer1.id,
                                   merchant_id: merchant1.id,
                                   status:      "success") }

  let!(:invoice2) { Invoice.create(customer_id: customer1.id,
                                   merchant_id: merchant1.id,
                                   status:      "success") }

  let!(:invoice3) { Invoice.create(customer_id: customer2.id,
                                   merchant_id: merchant2.id,
                                   status:      "failed") }

  let!(:invoice_item1) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: invoice1.id,
                                            quantity:   3,
                                            unit_price: 4) }

  let!(:invoice_item2) { InvoiceItem.create(item_id:    item2.id,
                                            invoice_id: invoice1.id,
                                            quantity:   3,
                                            unit_price: 4) }

  let!(:invoice_item3) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: invoice2.id,
                                            quantity:   7,
                                            unit_price: 8) }

  let!(:item1) { Item.create(name:        "Test Item",
                             description: "Test Description",
                             unit_price:  1,
                             merchant_id: 1) }

  let!(:item2) { Item.create(name:        "Such Car",
                             description: "So Wow",
                             unit_price:  3,
                             merchant_id: 2) }


  describe "GET #show" do
    it "returns the correct invoice" do
      get :show, id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq invoice1.id
    end
  end

  describe "GET #index" do
    it "returns the right number of invoices" do
      number_of_invoices = Invoice.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_invoices
    end
  end

  describe "GET #find" do
    it "returns the correct invoice by id" do
      get :find, id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq invoice1.id
    end

    it "returns the correct invoice by customer id" do
      get :find, customer_id: invoice1.customer_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["customer_id"]).to eq invoice1.customer_id
    end

    it "returns the correct invoice by merchant id" do
      get :find, merchant_id: invoice1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["merchant_id"]).to eq invoice1.merchant_id
    end

    it "returns the correct invoice by status" do
      get :find, status: invoice1.status, format: :json

      expect(response).to have_http_status :success
      expect(json_response["status"]).to eq invoice1.status
    end
  end

  describe "GET #find_all" do
    it "returns the correct invoice by id" do
      get :find_all, id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["id"]).to eq invoice1.id
    end

    it "returns the correct invoice by customer id" do
      get :find_all, customer_id: invoice1.customer_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["customer_id"]).to eq invoice1.customer_id
      expect(json_response.last["customer_id"]).to eq invoice1.customer_id
    end

    it "returns the correct invoice by merchant id" do
      get :find_all, merchant_id: invoice1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["merchant_id"]).to eq invoice1.merchant_id
      expect(json_response.last["merchant_id"]).to eq invoice1.merchant_id
    end

    it "returns the correct invoice by status" do
      get :find_all, status: invoice1.status, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["status"]).to eq invoice1.status
      expect(json_response.last["status"]).to eq invoice1.status
    end
  end

  describe "GET #random" do
    it "returns an invoice" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #transactions" do
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

    it "returns transactions for an invoice" do
      get :transactions, invoice_id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq transaction1.id
      expect(json_response.last["id"]).to eq transaction2.id
    end
  end

  describe "GET #invoice items" do
    it "returns invoice items for an invoice" do
      get :invoice_items, invoice_id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq invoice_item1.id
      expect(json_response.last["id"]).to eq invoice_item2.id
    end
  end

  describe "GET #items" do
    it "returns items for an invoice" do
      get :items, invoice_id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq item1.id
      expect(json_response.last["id"]).to eq item2.id
    end
  end

  describe "GET #customer" do

    it "returns a customer for an invoice" do
      get :customer, invoice_id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq customer1.id
    end
  end

  describe "GET #merchant" do

    it "returns a merchant for an invoice" do
      get :merchant, invoice_id: invoice1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq merchant1.id
    end
  end
end
