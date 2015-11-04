require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let(:customer) { Customer.create(first_name: "Test", last_name: "Customer") }

  describe "GET #show" do
    it "returns the correct customer" do
      get :show, id: customer.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer.first_name
      expect(json_response["last_name"]).to eq customer.last_name
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
      get :find, id: customer.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["first_name"]).to eq customer.first_name
      expect(json_response["id"]).to eq customer.id
    end

    it "returns the correct customer by name" do
      get :find, first_name: customer.first_name, format: :json
      byebug
      expect(json_response["first_name"]).to eq customer.first_name
      expect(json_response["id"]).to eq customer.id
    end
  end
end
