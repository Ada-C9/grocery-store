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
      product_exists = @products.has_key?(product_name) == false
      @products[product_name] = product_price if product_exists
      return product_exists
    end#end add product method

    #returns a collection of Order instances, representing all of the Orders
    #described in the CSV. See below for the CSV file specifications
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
      return orders #array of instances of Order
    end#self.all method

    # returns an instance of Order where the value of the id field in the
    # CSV matches the passed parameter.
    def self.find(id)
      return_val = nil
      if all.include? id
        return_val = all[id-1]
      end
      return return_val
    end#self.find method

  end#end Order class

end#end Grocery module

products = { "banana" => 1.99, "cracker" => 3.00 }
online_order = OnlineOrder.new(1,products)
