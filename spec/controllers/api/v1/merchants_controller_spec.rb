require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  let(:merchant) { Merchant.create(name: "Test Merchant") }

  describe "GET #show" do
    it "returns http success" do
      get :show, format: :json, id: merchant.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

end
