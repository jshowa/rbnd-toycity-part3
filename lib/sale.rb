require_relative "transaction"

class Sale < Transaction

  def initialize(customer, product)
    super(customer, product)
  end

  def alter_stock
    @product.lower_stock
  end
end
