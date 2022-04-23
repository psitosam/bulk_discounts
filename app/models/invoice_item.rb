class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  # def find_discount(id)
  #   invoice_item = InvoiceItem.find(id)
  #   bulk_discounts = BulkDiscount.order(:threshold)
  #   discount = nil
  #   bulk_discounts.each do |bd|
  #     if invoice_item.quantity >= bd.threshold
  #       discount = d
  #     end
  #   end
  #   discount
  # end
  #above method has a lot of Ruby, but does the same thing as the below method:

  def match_invoice_item_to_discount
    bulk_discounts.where('bulk_discounts.threshold <= ?', quantity)
                  .select('bulk_discounts.*')
                  .order(percent: :desc)
                  .first
  end
  #above method also gets the best possible discount, if more than one exist. This assumes a scenario where the merchant is offering the best possible discount as a service, and that it is not up to the customer to select their discount at checkout.
end
