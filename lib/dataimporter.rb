require 'json'

class DataImporter

  public

  attr_reader :path, :name, :full_path, :parsed_data
  
  def initialize(path, name)
    @path = path
    @name = name
    
    @full_path = File.join(path, name)

    if !File.exist?(@full_path)
      raise FileNotFoundError, "'#{@full_path}' doesn't exist."
    else
      @file = File.read(@full_path)
    end
  end

  def JSON_parser
    @parsed_data = JSON.parse(@file)
  end

  def JSON_add_products
    @parsed_data["items"].each { |product|
      Product.new(title: product["title"],
                  description: product["description"],
                  price: product["full-price"],
                  stock: product["stock"])
    } 
  end

  def JSON_add_transactions
    product = nil
    customer = nil
    
    @parsed_data["items"].each { |prod|

      product = Product.find_by_title(prod["title"]) # error if can't find product

      prod["purchases"].each { |trans|
        customer = Customer.find_by_name((trans["user"])["name"]) # error if can't find customer

        Transaction.new(customer,
                        product,
                        channel: trans["channel"],
                        date: trans["date"],
                        price: trans["price"],
                        shipping: trans["shipping"],
                        currency: trans["currency"])

      }
    }
  end

  def JSON_add_customers
    @parsed_data["items"].each { |product|

      product["purchases"].each { |trans|
        name = (trans["user"])["name"]
        state = (trans["user"])["state"]
        Customer.new(name: name, state: state)
      }
    }
  end
end
