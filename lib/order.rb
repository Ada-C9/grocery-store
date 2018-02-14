require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = 0
      # loop that adds each product value to subtotal
      @products.each do |key, value|
          subtotal += value
      end
      # returns the (subtotal + tax) and rounds to two decimals
      return (subtotal * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      #checks if the products hash contains product_name
      if @products.has_key?(product_name)
        return false
      else
        #adds product_name & product_price to @products
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name, product_price)
      if @products.has_key?(product_name) == false
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

  end
end
