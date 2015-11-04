require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let!(:invoice1) { Invoice.create(customer_id: 1,
                                   merchant_id: 1,
                                   status:      "success") }

  let!(:invoice2) { Invoice.create(customer_id: 1,
                                   merchant_id: 1,
                                   status:      "success") }

  let!(:invoice3) { Invoice.create(customer_id: 2,
                                   merchant_id: 3,
                                   status:      "failed") }

  let!(:invoice_item1) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: invoice1.id,
                                            quantity:   3,
                                            unit_price: item1.unit_price) }

  let!(:invoice_item2) { InvoiceItem.create(item_id:    item1.id,
                                            invoice_id: invoice1.id,
                                            quantity:   3,
                                            unit_price: item1.unit_price) }

  let!(:invoice_item3) { InvoiceItem.create(item_id:    item2.id,
                                            invoice_id: invoice2.id,
                                            quantity:   7,
                                            unit_price: item2.unit_price) }

  let!(:item1) { Item.create(name:        "Test Item",
                             description: "Test Description",
                             unit_price:  1,
                             merchant_id: 1) }

  let!(:item2) { Item.create(name:        "Test Item 2",
                             description: "Test Description 2",
                             unit_price:  2,
                             merchant_id: 1) }

  describe "GET #show" do
    it "returns the correct invoice item" do
      get :show, id: invoice_item1.id, format: :json

      expect(response).to have_http_status(:success)
      expect(json_response["id"]).to eq invoice_item1.id
    end
  end

  describe "GET #index" do
    it "returns the right number of invoice items" do
      number_of_invoice_items = InvoiceItem.count
      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(json_response.count).to eq number_of_invoice_items
    end
  end

  describe "GET #find" do
    it "returns the correct invoice item by id" do
      get :find, id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["item_id"]).to eq invoice_item1.item_id
      expect(json_response["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct invoice item by item id" do
      get :find, item_id: invoice_item1.item_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
      expect(json_response["id"]).to eq invoice_item1.id
    end

    it "returns the correct invoice_item by invoice id" do
      get :find, invoice_id: invoice_item1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
      expect(json_response["id"]).to eq invoice_item1.id
    end

    it "returns the correct invoice_item by quantity" do
      get :find, quantity: invoice_item1.quantity, format: :json

      expect(response).to have_http_status :success
      expect(json_response["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct_invoice item by unit price" do
      get :find, unit_price: invoice_item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response["unit_price"].to_f).to eq invoice_item1.unit_price
    end
  end

  describe "GET #find_all" do
    it "returns the correct invoice items by id" do
      get :find_all, id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 1
      expect(json_response.first["item_id"]).to eq invoice_item1.item_id
      expect(json_response.first["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct invoice items by item id" do
      get :find_all, item_id: invoice_item1.item_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["item_id"]).to eq invoice_item1.item_id
      expect(json_response.last["item_id"]).to eq invoice_item1.item_id
    end

    it "returns the correct invoice_items by invoice id" do
      get :find_all, invoice_id: invoice_item1.invoice_id, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["invoice_id"]).to eq invoice_item1.invoice_id
      expect(json_response.last["invoice_id"]).to eq invoice_item1.invoice_id
    end

    it "returns the correct invoice_items by quantity" do
      get :find_all, quantity: invoice_item1.quantity, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["quantity"]).to eq invoice_item1.quantity
      expect(json_response.last["quantity"]).to eq invoice_item1.quantity
    end

    it "returns the correct_invoice items by unit price" do
      get :find_all, unit_price: invoice_item1.unit_price, format: :json

      expect(response).to have_http_status :success
      expect(json_response.count).to eq 2
      expect(json_response.first["unit_price"].to_f).to eq invoice_item1.unit_price
      expect(json_response.last["unit_price"].to_f).to eq invoice_item1.unit_price
    end
  end

  describe "GET #random" do
    it "returns an invoice item" do
      get :random, format: :json

      expect(response).to have_http_status :success
    end
  end

  describe "GET #invoice" do
    it "returns the invoice for an invoice item" do
      get :invoice, invoice_item_id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq invoice1.id
    end
  end

  describe "GET #item" do
    it "returns the item for an invoice item" do
      get :item, invoice_item_id: invoice_item1.id, format: :json

      expect(response).to have_http_status :success
      expect(json_response["id"]).to eq item1.id
    end
  end

end
