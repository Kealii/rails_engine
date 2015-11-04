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
end
