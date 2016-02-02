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

  attr_reader :customer, :product, :id, :date, :channel, :price, :shipping, :currency
  
  def initialize(customer, product, options={})
    @customer = customer.is_a?(Customer) ? customer : nil
    @product = product.is_a?(Product) ? product : nil
    @channel = options[:channel] || "default"
    @date = options[:date] || "1990-01-01T00:00:00+00:00"
    @shipping = options[:shipping] || 0.0
    @price = options[:price] || 0.0
    @currency = options[:currency] || "USD"
    
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

  def self.clear
    (@@transactions.length).times do
      @@transactions.pop
    end

    @@id = 1
  end

  def puts
    return "#{@id}, " +
      "#{@customer.name}, " +
      "#{@product.title}, " +
      "#{@channel}, " +
      "#{@date}, " +
      "#{@price}, " +
      "#{@shipping}, " +
      "#{@currency}"
  end
end  
