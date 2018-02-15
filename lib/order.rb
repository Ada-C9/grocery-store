require 'awesome_print'

module Grocery


  class Order
    attr_reader :id, :products

    # id: Integer, represents unique identifier
    # input_products: hash that represents products with keys of product name and values of price (Float)
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = @products.values.sum
      sum = subtotal + (subtotal * 0.075).round(2)
      return sum
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      # before_count = @products.count
      # expected_count = before_count + 1

      # @products[product_name] = product_price
      # puts "product list is now: #{@products}"

      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        puts "product list is now: #{@products}"
      end

    end #end of add_product method

  end #end of class



end #end of module
