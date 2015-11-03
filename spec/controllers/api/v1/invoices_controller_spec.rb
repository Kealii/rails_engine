require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  let(:invoice) { Invoice.create(customer_id: 1,
                                 merchant_id: 2,
                                 status: "success") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: invoice.id, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the correct invoice" do
      get :show, id: invoice.id, format: :json
      expect(json_response["status"]).to eq invoice.status
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status :success
    end

    it "returns the right number of invoices" do
      number_of_invoices = Invoice.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_invoices
    end
  end

end
