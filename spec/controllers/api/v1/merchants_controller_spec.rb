require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let(:merchant) { Merchant.create(name: "Test Merchant") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: merchant.id, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the correct invoice" do
      get :show, id: merchant.id, format: :json
      expect(json_response["name"]).to eq merchant.name
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the right number of invoices" do
      number_of_merchants = Merchant.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_merchants
    end
  end


end
