class Transaction
  
  private
  
  @@transactions = []
  @@id = 1

  def add_transaction
    @product.lower_stock
    @id = @@id
    @@transactions << self
    @@id += 1
  end

  public

  attr_reader :customer, :product, :id
  
  def initialize(customer, product)
    @customer = customer.is_a?(Customer) ? customer : nil
    @product = product.is_a?(Product) ? product : nil
    add_transaction
  end

  def self.find(i = 1)
    @@transactions.select { |transaction| transaction.id == i  }[0]
  end

  def self.all
    @@transactions
  end

  def self.count
    @@transactions.length
  end
end  
