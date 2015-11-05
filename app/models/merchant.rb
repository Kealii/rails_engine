class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def self.revenue_ranking(quantity)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum("quantity * unit_price")]
    end
    top_merchants.sort_by { |merchant| merchant.last }.reverse.map(&:first).first(quantity.to_i)
  end

  def self.item_ranking(quantity)
    top_merchants = Merchant.all.map do |merchant|
      [merchant, merchant.invoices.successful.joins(:invoice_items).sum(:quantity)]
    end
    top_merchants.sort_by { |merchant| merchant.last }.reverse.map(&:first).first(quantity.to_i)
  end

  def self.total_revenue_by_date(date)
    { total_revenue: Invoice.all.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def revenue(params)
    if params[:date]
      revenue_by_date(params[:date])
    else
      total_revenue
    end
  end

  def revenue_by_date(date)
    { revenue: invoices.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def total_revenue
    { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def favorite_customer
    successful_invoices = invoices.successful.group_by(&:customer_id)
    sorted_invoices = successful_invoices.sort_by { |_, v| v.count }.reverse.flatten
    top_customer = sorted_invoices.first
    Customer.find(top_customer)
  end

  def pending_invoices
    invoices.pending.joins(:customer).uniq
  end

end
