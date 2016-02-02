class Product
  
  private
  
  @@products = []

  def add_product
    if Product.find_by_title(@title) != nil
      raise DuplicateProductError, "'#{@title}' already exists."
    end
    @@products << self
  end

  public

  attr_reader :title, :price, :stock, :description
  
  def initialize(arguments={})
    @title = arguments[:title] || ""
    @price = arguments[:price].to_f || 0.0
    @stock = arguments[:stock].to_i || 0
    @description = arguments[:description] || ""
    add_product
  end

  def lower_stock
    if !in_stock?
      raise OutOfStockError, "'#{@title}' is out of stock." 
    else
      @stock -= 1
    end
  end

  def raise_stock
    @stock += 1
  end

  def in_stock?
    (@stock > 0)
  end

  def puts
    "#{@title}, #{@description}, #{@price}, #{@stock}"
  end
  
  def self.in_stock
    @@products.select { |product| product.stock > 0 }
  end

  def self.find_by_title(target = "")
    @@products.select { |product| product.title == target }[0]
  end

  def self.all
    @@products
  end

  def self.count
    @@products.length
  end

  def self.clear
    (@@products.length).times do
      @@products.pop
    end
  end

  def self.puts
    @@products.each { |prod|
      prod.puts
    }
  end
end  
