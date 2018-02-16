require 'awesome_print'
require 'csv'

# CSV.read("orders.csv")
# CSV.open("orders.csv", mode='r')

# manually choose the data from the first line of the CSV file and ensure you can create a new instance of your Order using that data

module Grocery


  class Order
    attr_reader :id, :products
    # id: Integer, represents unique identifier
    # input_products: hash that represents products with keys of product name and values of price (Float)


    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      array_of_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        array_of_orders << line
      end
      return array_of_orders
    end



    def total
      subtotal = @products.values.sum
      sum = subtotal + (subtotal * 0.075).round(2)
      return sum
    end

    def add_product(product_name, product_price)

      return false if @products.has_key?(product_name)
      @products[product_name] = product_price
      return true
    end #end of add_product method


    #	• Add a remove_product method to the Order class which will take in one parameter, a product name, and remove the product from the collection
		# It should return true if the item was successfully remove and false if it was not

    def remove_product(product_name)
      p @products
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end




  end #end of class



end #end of module

# ap Grocery::Order.all
