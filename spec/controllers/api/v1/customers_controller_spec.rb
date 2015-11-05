require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let!(:customer1) { Customer.create(first_name: "Test",  last_name: "Customer") }
  let!(:customer2) { Customer.create(first_name: "Test",  last_name: "Strife"  ) }

  let!(:merchant1) { Merchant.create(name: "Test Merchant") }
  let!(:merchant2) { Merchant.create(name: "Test Merchant") }

  let!(:transaction1) { Transaction.create(invoice_id: invoice1.id,
                                           result:     "success") }
  let!(:transaction2) { Transaction.create(invoice_id: invoice2.id,
                                           result:     "success") }
  let!(:transaction3) { Transaction.create(invoice_id: invoice3.id,
                                           result:     "failed") }

  let!(:invoice1) { Invoice.create(customer_id: customer1.id,
                                   merchant_id: merchant1.id,
                                   status:      "success") }

  let!(:invoice2) { Invoice.create(customer_id: customer1.id,
                                   merchant_id: merchant1.id,
                                   status:      "success") }

  let!(:invoice3) { Invoice.create(customer_id: customer2.id,
                                   merchant_id: merchant2.id,
                                   status:      "success") }

  describe "GET #show" do
    it "returns the correct customer" do
      get :show, id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer1.first_name
      expect(json_response["last_name"]).to eq customer1.last_name
    end
  end

  describe "GET #index" do
    it "returns the right number of customers" do
      number_of_customers = Customer.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_customers
    end
  end

  describe "GET #find" do
    it "returns the correct customer by id" do
      get :find, id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer1.first_name
      expect(json_response["id"]).to eq customer1.id
    end

    it "returns a customer by first name" do
      get :find, first_name: customer1.first_name, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer1.first_name
    end

    it "returns a customer by last name" do
      get :find, first_name: customer1.first_name, format: :json

      expect(response).to have_http_status :success
      expect(json_response["last_name"]).to eq customer1.last_name
    end
  end

  describe "GET #find_all" do
    it "returns the correct customers by id" do
      get :find_all, id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["id"]).to eq customer1.id
      expect(json_response.last["first_name"]).to eq customer2.first_name
    end

    it "returns the correct customers by first_name" do
      get :find_all, first_name: "Test", format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["first_name"]).to eq customer1.first_name
      expect(json_response.last["first_name"]).to eq customer2.first_name
      expect(json_response.last["last_name"]).to eq customer2.last_name
    end

    it "returns the correct customers by last_name" do
      get :find_all, first_name: "Test", format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["first_name"]).to eq customer1.first_name
      expect(json_response.last["first_name"]).to eq customer2.first_name
      expect(json_response.last["last_name"]).to eq customer2.last_name
    end
  end

  describe "GET #random" do
    it "returns a customer" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #invoices" do
    it "returns invoices for a customer" do
      get :invoices, customer_id: customer1.id, format: :json
      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq invoice1.id
      expect(json_response.last["id"]).to eq invoice2.id
    end
  end

  describe "GET #transactions" do
    it "returns transactions for a customer" do
      get :transactions, customer_id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq transaction1.id
      expect(json_response.last["id"]).to eq transaction2.id
    end
  end

  describe "GET #favorite_merchant" do
    it "receives a response" do
      get :favorite_merchant, customer_id: customer1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq merchant1.id
    end
  end
end