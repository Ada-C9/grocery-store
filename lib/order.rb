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
    end

    #A total method which will calculate the total cost of the order by:
    def total
      # TODO: implement total
        sum = 0
        subtotal = @products.values
        subtotal.each do |price|
          sum += price.to_f
        end
        # subtotal = new_array.inject{ |a,b| a + b }
         total = (sum * 1.075).round(2)
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
      orders = []
      #opening CSV
      CSV.read(FILE_NAME, 'r').each do |order|

        step1 = order[1].split(";")
        step2 = []

        step1.each do |pair|
          step2 << pair.split(":")
        end
        products = step2.to_h
        orders << Grocery::Order.new(order[0].to_i,products)
      end#reads and parses through CSV file
      return orders
    end#self.all method

    def self.find(id)
      return_val = nil
      if all.include? id
        return_val = all[id-1]
      end
      return return_val
    end#self.find method

  end#end Order class

end#end Grocery module.
