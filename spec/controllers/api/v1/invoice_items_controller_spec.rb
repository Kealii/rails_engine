require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let(:invoice_item) { InvoiceItem.create(item_id: 1,
                                         invoice_id: 2,
                                         quantity: 3,
                                         unit_price: 4) }

  describe "GET #show" do
    it "returns http success" do
      get :show, id: invoice_item.id, format: :json
      expect(response).to have_http_status(:success)
    end

    it "returns the correct invoice item" do
      get :show, id: invoice_item.id, format: :json
      expect(json_response["quantity"]).to eq invoice_item.quantity
      expect(json_response["unit_price"].to_f).to eq invoice_item.unit_price

    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end

    it "returns the right number of invoice items" do
      number_of_invoice_items = InvoiceItem.count
      get :index, format: :json
      expect(json_response.count).to eq number_of_invoice_items
    end
  end
end
