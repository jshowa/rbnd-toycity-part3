class Transaction
  
  private
  
  @@transactions = []
  @@id = 1

  def add_transaction
    alter_stock
    @id = @@id
    @@transactions << self
    @@id += 1
  end

  def alter_stock
    if self.instance_of?(Sale) || self.instance_of?(Transaction)
      @product.lower_stock
    elsif self.instance_of?(Return)
      @prouct.raise_stock
    end
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
