require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let!(:item1) { Item.create(name:        "Test Item",
                             description: "Test Description",
                             unit_price:  1,
                             merchant_id: merchant1.id) }

  let!(:item2) { Item.create(name:        "Test Item",
                             description: "Test Description",
                             unit_price:  1,
                             merchant_id: merchant1.id) }

  let!(:item3) { Item.create(name:        "Such Car",
                             description: "So Wow",
                             unit_price:  3,
                             merchant_id: merchant2.id) }

  let!(:invoice_item1) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: 1,
                                            quantity:   3,
                                            unit_price: 4) }

  let!(:invoice_item2) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: 1,
                                            quantity:   3,
                                            unit_price: 4) }

  let(:merchant1) { Merchant.create(name: "Test Merchant") }
  let(:merchant2) { Merchant.create(name: "Test Merchant 2") }

  describe "GET #show" do
    it "returns the correct item" do
      get :show, id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq item1.id
    end
  end

  describe "GET #index" do
    it "returns the right number of items" do
      number_of_items = Item.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_items
    end
  end

  describe "GET #find" do
    it "returns the correct item by id" do
      get :find, id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq item1.id
    end

    it "returns the correct item by name" do
      get :find, name: item1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response["name"]).to eq item1.name
    end

    it "returns the correct item by description" do
      get :find, description: item1.description, format: :json

      expect(response).to have_http_status :success
      expect(json_response["description"]).to eq item1.description
    end

    it "returns the correct item by unit price" do
      get :find, unit_price: item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response["unit_price"].to_f).to eq item1.unit_price
    end

    it "returns the correct item by merchant id" do
      get :find, status: item1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["merchant_id"]).to eq item1.merchant_id
    end
  end

  describe "GET #find_all" do
    it "returns the correct items by id" do
      get :find_all, id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["id"]).to eq item1.id
    end

    it "returns the correct items by name" do
      get :find_all, name: item1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["name"]).to eq item1.name
      expect(json_response.last["name"]).to eq item1.name

    end

    it "returns the correct items by description" do
      get :find_all, description: item1.description, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["description"]).to eq item1.description
      expect(json_response.last["description"]).to eq item1.description
    end

    it "returns the correct items by unit price" do
      get :find_all, unit_price: item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["unit_price"].to_f).to eq item1.unit_price
      expect(json_response.last["unit_price"].to_f).to eq item1.unit_price
    end

    it "returns the correct items by merchant id" do
      get :find_all, merchant_id: item1.merchant_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["merchant_id"]).to eq item1.merchant_id
      expect(json_response.last["merchant_id"]).to eq item1.merchant_id
    end
  end

  describe "GET #random" do
    it "returns an item" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #invoice_items" do
    it "returns invoice items for an item" do
      get :invoice_items, item_id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["id"]).to eq invoice_item1.id
      expect(json_response.last["id"]).to eq invoice_item2.id
    end
  end

  describe "GET #merchant" do
    it "returns merchant for an item" do
      get :merchant, item_id: item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq merchant1.id
    end
  end

  describe "GET #most_revenue" do
    it "returns top items by revenue" do
      get :most_revenue, quantity: 2, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #most_items" do
    it "returns top items by number sold" do
      get :most_items, quantity: 2, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #best_day" do
    it "returns date of most sales for an item" do
      get :best_day, item_id: item1.id, format: :json

      expect(response).to have_http_status :success
    end
  end
end
