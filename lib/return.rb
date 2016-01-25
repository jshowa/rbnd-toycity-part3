require_relative "transaction"

class Return < Transaction

  def initialize(customer, product)
    super(customer, product)
  end

  def alter_stock
    @product.raise_stock
  end
end
