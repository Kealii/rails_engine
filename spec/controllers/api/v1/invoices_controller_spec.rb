require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  let(:invoice) { Invoice.create(customer_id: "1",
                                 merchant_id: "1",
                                 status: "success") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: invoice.id, format: :json
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
