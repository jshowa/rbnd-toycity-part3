class Customer
  
  private
  
  @@customers = []
  @@id = 1

  def add_customer
    if Customer.find_by_name(@name) != nil
      raise DuplicateCustomerError, "'#{@name}' already exists."
    end
    @id = @@id
    @@customers << self
    @id += 1
  end

  public

  attr_reader :name, :state, :id
  
  def initialize(arguments={})
    @name = arguments[:name] || ""
    @state = arguments[:state] || ""
    add_customer
  end

  def purchase(product)
    Sale.new(self, product)
  end

  def return(product)
    Return.new(self, product)
  end

  def puts
    "#{@name}, #{@state}" 
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

  def self.clear
    (@@customers.length).times do
      @@customers.pop
    end

    @@id = 1
  end

  def self.puts
    @@customers.each { |cust|
      puts "#{cust.name}, #{cust.state}"
    }
  end
end
