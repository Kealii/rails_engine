require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let(:item) { Item.create(name: "Test Item",
                           description: "Test Description",
                           unit_price: 1,
                           merchant_id: 2) }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: item.id, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the correct invoice" do
      get :show, id: item.id, format: :json
      expect(json_response["name"]).to        eq item.name
      expect(json_response["description"]).to eq item.description
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the right number of invoices" do
      number_of_items = Item.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_items
    end
  end

end
