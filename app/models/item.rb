class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  before_save :convert_unit_price

  def convert_unit_price
    self.unit_price = self.unit_price/100
  end

  def self.most_revenue(quantity)
    top_items = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity * unit_price")]
    end
    sorted_items = top_items.sort_by { |item| item.last }.reverse
    sorted_items.map(&:first).first(quantity.to_i)
  end

  def self.most_items(quantity)
    top_items = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity")]
    end
    sorted_items = top_items.sort_by { |item| item.last }.reverse
    sorted_items.map(&:first).first(quantity.to_i)
  end
end