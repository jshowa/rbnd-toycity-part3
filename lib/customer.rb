class Customer
  
  private
  
  @@customers = []
  @@id = 0

  def add_customer
    if Customer.find_by_name(@name) != nil
      raise DuplicateCustomerError, "'#{@name}' already exists."
    end
    @id = @@id
    @@customers << self
    @id += 1
  end

  public

  attr_reader :name, :id
  
  def initialize(arguments={})
    @name = arguments[:name] || ""
    add_customer
  end

  def self.find_by_name(target = "")
    @@customers.select { |customer| customer.name == target }[0]
  end

  def self.all
    @@customers
  end

  def self.count
    @@customers.length
  end
end
