require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let(:customer) { Customer.create(first_name: "Test", last_name: "Customer") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: customer.id, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the correct record" do
      get :show, id: customer.id, format: :json
      expect(json_response["first_name"]).to eq "Test"
      expect(json_response["last_name"]).to eq "Customer"
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the right number of customers" do
      number_of_customers = Customer.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_customers
    end
  end
end
