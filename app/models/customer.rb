class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    successful_invoices = invoices.successful.group_by(&:merchant_id)
    sorted_invoices = successful_invoices.sort_by { |_, v| v.count }.reverse.flatten
    id = sorted_invoices.first
    Merchant.find(id)
  end
end