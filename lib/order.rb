require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    FILE_NAME = "support/orders.csv"

    @@orders = []

    def initialize(id, products)
      @id = id.to_i
      @products = products
    end

    def self.find(id)
      # finds an order in the collection of Order instances
      @@orders.each do |order|
        if order.id == id
          return order
        end
      end
      return "ERROR: order does not exist"
    end

    def self.all
      # returns a collection of Order instances,
      # representing all of the Orders described
      # in the CSV
      if @@orders.empty?
        CSV.open(FILE_NAME, 'r') do |file|
          file.each do |line_item|

            id = line_item[0]
            items_string = line_item[1]
            products = {} #will take k/v pairs delimited by colon

            semicolon_split = items_string.split(';')

            semicolon_split.each do |string|
              key_value_split = string.split(':')
              products[key_value_split[0]] = key_value_split[1].to_f
            end
            @@orders << Order.new(id,products)
          end
          return @@orders
        end
      else
        return @@orders
      end
    end


    def total
      sum = 0
      @products.each do |product, price|
        sum += price
      end
      total = (sum * 1.075).round(2)
      return total
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
