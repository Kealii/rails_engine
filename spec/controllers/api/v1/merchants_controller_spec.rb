require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let!(:merchant1) { Merchant.create(name: "Test Merchant") }
  let!(:merchant2) { Merchant.create(name: "Test Merchant") }
  let!(:merchant3) { Merchant.create(name: "Mercurio") }

  describe "GET #show" do
    it "returns the correct merchant" do
      get :show, id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["name"]).to eq merchant1.name
    end
  end

  describe "GET #index" do
    it "returns the right number of merchants" do
      number_of_merchants = Merchant.count
      get :index, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq number_of_merchants
    end
  end

  describe "GET #find" do
    it "returns the right merchant by id" do
      get :find, id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq merchant1.id
    end

    it "returns the right merchant by name" do
      get :find, name: merchant1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response["name"]).to eq merchant1.name
    end
  end

  describe "GET #find_all" do
    it "returns the right merchants by id" do
      get :find_all, id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["id"]).to eq merchant1.id
      expect(json_response.last["id"]).to eq merchant1.id
    end

    it "returns the right merchants by name" do
      get :find_all, name: merchant1.name, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["name"]).to eq merchant1.name
      expect(json_response.last["name"]).to eq merchant1.name
    end
  end

  describe "GET #random" do
    it "returns a merchant" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #items" do
    let!(:item1) { Item.create(name: "Item 1",
                               description: "Description 1",
                               unit_price:  1,
                               merchant_id: merchant1.id) }

    let!(:item2) { Item.create(name: "Item 2",
                               description: "Description 2",
                               unit_price: 1,
                               merchant_id: merchant1.id) }

    let!(:item3) { Item.create(name: "Item 3",
                               description: "Description 3",
                               unit_price: 2,
                               merchant_id: merchant2.id) }

    it "returns items for a merchant" do
      get :items, merchant_id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
    end
  end

  describe "GET #invoices" do
    let!(:invoice1) { Invoice.create(customer_id: 1,
                                     merchant_id: merchant1.id,
                                     status:      "success") }

    let!(:invoice2) { Invoice.create(customer_id: 1,
                                     merchant_id: merchant1.id,
                                     status:      "success") }

    let!(:invoice3) { Invoice.create(customer_id: 2,
                                     merchant_id: merchant2.id,
                                     status:      "failed") }

    it "returns invoices for a merchant" do
      get :invoices, merchant_id: merchant1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
    end
  end

  describe "GET #most_revenue" do
    it "returns the correct number of merchants by total revenue" do
      get :most_revenue, quantity: 2, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
    end
  end

  describe "GET #most_items" do
    it "returns the correct number of merchants by items sold" do
      get :most_items, quantity: 2, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
    end
  end

  describe "GET #revenues_by_date" do
    it "returns the correct revenues by date" do
      get :revenue, merchant_id: merchant1.id, date: merchant1.created_at, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #revenue" do
    it "returns the merchant revenue" do
      get :revenue, merchant_id: merchant1.id, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #revenue_by_date" do
    it "returns the correct revenue by date" do
      get :revenue_by_date, date: merchant1.created_at, format: :json

      expect(response).to have_http_status :success
    end
  end

end