require 'csv'
require 'awesome_print'

FILE_NAME = "../support/orders.csv"

# data = CSV.read(FILE_NAME)
# ap data
#
# data.each do |product|
#   puts " Product #{product[0]}: #{product[1]}"
# end

# CSV.open(FILE_NAME, 'r').each do |product|
# #  file.each do |product|
#     puts " Product #{product[0]}: #{product[1]}"
# #  end
# end

 module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # def total
    #   sum = products.values.inject(0, :+)
    #   total = sum + (sum * 0.075).round(2)
    #   return total
    # end

    def total
      sum = 0
      total = 0
      @products.each_value do |price|
        sum += price
      end
      return total = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
 end

# products = []
# CSV.open(FILE_NAME, 'r').each do |product|
#  #  file.each do |product|
#     puts " Product #{product[0]}: #{product[1]}"
#     products << Order.new(product[0], product[2])
#  #  end
#  end
