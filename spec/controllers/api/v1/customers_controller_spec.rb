require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  let(:customer) { Customer.create(first_name: "Test", last_name: "Customer") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: customer.id, format: :json
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
