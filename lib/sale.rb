require_relative "transaction"

class Sale < Transaction

  def initialize(customer, product, options={})
    super(customer, product, {channel: options[:channel], date: options[:date], price: options[:price], shipping: options[:shipping], currency: options[:currency]})
  end

  def alter_stock
    @product.lower_stock
  end
end
