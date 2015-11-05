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
    item_quantities = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity")]
    end
    sorted_items = item_quantities.sort_by { |item| item.last }.reverse
    sorted_items.map(&:first).first(quantity.to_i)
  end

  def best_day
    invoice_days = invoices.successful.group('"invoices"."created_at"')
    invoice_revenues = invoice_days.sum("quantity * unit_price")
    sorted_revenues = invoice_revenues.sort_by(&:last).map(&:first)
    best_day = sorted_revenues.last
    { best_day: best_day }
  end
end