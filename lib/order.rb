require 'csv'
require 'awesome_print'
require 'pry'

FILE_NAME = 'support/orders.csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      orders = []
      @orders = orders
    end

    #A total method which will calculate the total cost of the order by:
    def total
      # TODO: implement total
      total = 0
      if @products.length > 0
        subtotal = @products.values.inject{ |a,b| a + b }
        total = (subtotal * 1.075).round(2)
      end
      return total
    end

    #An add_product method that adds the data to the product collection
    def add_product(product_name, product_price)
      # TODO: implement add_product
      #binding.pry
      product_exists = @products.has_key?(product_name) == false
      @products[product_name] = product_price if product_exists
      return product_exists
    end

    def self.all


      #opening CSV
      CSV.read(FILE_NAME, 'r').each do |order|
        orders = []
        step1 = order[1].split(";")
        step2 = []

        step1.each do |pair|
          step2 << pair.split(":")
        end
        products = step2.to_h
        orders << Grocery::Order.new(order[0],products)
        return orders

      end#reads and parses through CSV file

    end#self.all method

    def self.find(id)
      id = id.to_i
      return @orders[i]
    end#self.find method

  end#end Order class

end#end Grocery module


print Grocery::Order.all()


# #opening CSV
# CSV.read(FILE_NAME, 'r').each do |order|
#   step1 = order[1]
#   step2 = step1.split(";")
#   step3 = []
#
#   step2.each do |pair|
#     step3 << pair.split(":")
#   end
#   products = step3.to_h
#   puts products
#   orders << Grocery::Order.new(order[0],products)
# end#reads and parses through CSV file
