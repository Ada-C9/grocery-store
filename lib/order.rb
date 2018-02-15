require "csv"
require "ap"



module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum =   @products.values.sum
      return sum + (sum * 0.075).round(2)
    end

    def add_product (product_name, product_price)
      if @products.keys.include?(product_name) != true
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end
  end
end


csv_array_data = CSV.read("../support/orders.csv", "r")

ap csv_array_data
