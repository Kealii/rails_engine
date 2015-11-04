class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.revenue_ranking(quantity)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity * unit_price")]
    end
    top_merchants.sort_by { |merchant| merchant.last }.reverse.map(&:first).first(quantity.to_i)
  end
end
