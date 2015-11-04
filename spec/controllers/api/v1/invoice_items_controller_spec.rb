require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let!(:invoice_item1) { InvoiceItem.create(item_id:   1,
                                           invoice_id: 2,
                                           quantity:   3,
                                           unit_price: 4) }

  let!(:invoice_item2) { InvoiceItem.create(item_id:   1,
                                           invoice_id: 2,
                                           quantity:   3,
                                           unit_price: 4) }

  let!(:invoice_item3) { InvoiceItem.create(item_id:   5,
                                           invoice_id: 6,
                                           quantity:   7,
                                           unit_price: 8) }

  describe "GET #show" do
    it "returns the correct invoice item" do
      get :show, id: invoice_item1.id, format: :json

      expect(response).to have_http_status(:success)
      expect(json_response["id"]).to eq invoice_item1.id
    end
  end

  describe "GET #index" do
    it "returns the right number of invoice items" do
      number_of_invoice_items = InvoiceItem.count
      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(json_response.count).to eq number_of_invoice_items
    end
  end

  describe "GET #find" do
    it "returns the correct invoice item by id" do
      get :find, id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["item_id"]).to eq invoice_item1.item_id
      expect(json_response["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct invoice item by item id" do
      get :find, item_id: invoice_item1.item_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
      expect(json_response["id"]).to eq invoice_item1.id
    end

    it "returns the correct invoice_item by invoice id" do
      get :find, invoice_id: invoice_item1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
      expect(json_response["id"]).to eq invoice_item1.id
    end

    it "returns the correct invoice_item by quantity" do
      get :find, quantity: invoice_item1.quantity, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct_invoice item by unit price" do
      get :find, unit_price: invoice_item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response["unit_price"].to_f).to eq invoice_item1.unit_price
    end
  end

  describe "GET #find_all" do
    it "returns the correct invoice items by id" do
      get :find_all, id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["item_id"]).to eq invoice_item1.item_id
      expect(json_response.first["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct invoice items by item id" do
      get :find_all, item_id: invoice_item1.item_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["item_id"]).to eq invoice_item1.item_id
      expect(json_response.last["item_id"]).to eq invoice_item1.item_id
    end

    it "returns the correct invoice_items by invoice id" do
      get :find_all, invoice_id: invoice_item1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["invoice_id"]).to eq invoice_item1.invoice_id
      expect(json_response.last["invoice_id"]).to eq invoice_item1.invoice_id
    end

    it "returns the correct invoice_items by quantity" do
      get :find_all, quantity: invoice_item1.quantity, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["quantity"]).to eq invoice_item1.quantity
      expect(json_response.last["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct_invoice items by unit price" do
      get :find_all, unit_price: invoice_item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["unit_price"].to_f).to eq invoice_item1.unit_price
      expect(json_response.last["unit_price"].to_f).to eq invoice_item1.unit_price
    end
  end
end
