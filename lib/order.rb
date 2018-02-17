require "colorize"
require "colorized_string"
require "awesome_print"
require "csv"

module Grocery
  class Order
    attr_reader :id, :products, :add_product, :total, :result#, :product_name, :product_price

#Takes an ID and collection of products
    def initialize(id, products)
      if id == id.to_i
        @id = id
      else
        id = rand(1111..9999)
        @id = id
      end
      @products = products
    end

    #Returns the total price from the collection of products
    def total
      # TODO: implement total
      if products.length == 0
         return 0
      end
      ((@products.values.sum)*1.075).round(2)
    end

# Increases the number of products
    def add_product(product_name, product_price)
      # TODO: implement add_product
      # @product_name = product_name
      # @product_price = product_price
      if @products.include?(product_name) == false
        @products[product_name] = product_price
        result = true
      else
        result = false
      end
      @result = result
    end
  end
end
