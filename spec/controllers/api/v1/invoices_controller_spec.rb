require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  let!(:invoice1) { Invoice.create(customer_id: 1,
                                 merchant_id: 2,
                                 status: "success") }

  let!(:invoice2) { Invoice.create(customer_id: 1,
                                  merchant_id: 2,
                                  status: "success") }

  let!(:invoice3) { Invoice.create(customer_id: 3,
                                  merchant_id: 4,
                                  status: "failed") }

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
end
