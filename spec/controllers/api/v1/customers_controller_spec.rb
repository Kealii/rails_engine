require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let!(:customer1) { Customer.create(first_name: "Test",  last_name: "Customer") }
  let!(:customer2) { Customer.create(first_name: "Test",  last_name: "Strife"  ) }

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

    it "returns the correct customer by first name" do
      get :find, first_name: customer1.first_name, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer1.first_name
      expect(json_response["id"]).to eq customer1.id
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
end
