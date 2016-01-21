class Product
  
  private
  
  @@products = []

  def add_product
    if (@@products.select { |product| product.title == @title }.length) > 0
      raise DuplicateProductError, "'#{@title}' already exists."
    end
    @@products << self
  end

  public

  attr_reader :title
  
  def initialize(arguments={})
    @title = arguments[:title] || ""
    @price = arguments[:price] || 0.0
    @stock = arguments[:stock] || 0
    add_product
  end

  def self.all
    @@products
  end

  def self.count
    @@products.length
  end
end  
