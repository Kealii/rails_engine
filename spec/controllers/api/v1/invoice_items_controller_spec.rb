require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let(:invoice_item) { InvoiceItem.create(item_id: "1",
                                         invoice_id: "1",
                                         quantity: "1",
                                         unit_price: "1") }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: invoice_item.id, format: :json
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
