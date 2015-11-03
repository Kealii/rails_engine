require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let(:item) { Item.create(name: "Test Item",
                           description: "Test Description",
                           unit_price: "1",
                           merchant_id: "1") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: item.id, format: :json
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
