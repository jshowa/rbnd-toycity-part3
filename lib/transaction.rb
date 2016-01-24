class Transaction
  
  private
  
  @@transactions = []
  @@id = 0

  def add_transaction
    @id = @@id
    @@transactions << self
    @@id += 1
  end

  public

  attr_reader :customer, :product, :id
  
  def initialize(arguments={})
    @customer = arguments[:customer] || nil
    @product = arguments[:product] || nil
    add_transaction
  end

  def self.find(i = 0)
    @@transactions.select { |transaction| transaction.id == i }[i]
  end

  def self.all
    @@transactions
  end

  def self.count
    @@transactions.length
  end
end  
