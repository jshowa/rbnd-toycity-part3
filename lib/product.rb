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

  attr_reader :title, :price, :stock
  
  def initialize(arguments={})
    @title = arguments[:title] || ""
    @price = arguments[:price] || 0.0
    @stock = arguments[:stock] || 0
    add_product
  end

  def in_stock?
    (@stock > 0)
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
end  
