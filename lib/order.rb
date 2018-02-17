require 'csv'
require 'awesome_print'

FILE_NAME = 'support/orders.csv'

# orders_array = CSV.read(FILE_NAME, 'r')
# parsed_array = []
# orders_array.each_with_index do |order, i|
#   parsed_array[i] =[]
#   parsed_array[i][0] = order[0].to_i
#   parsed_array[i][1] = Hash[order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
# end
#
# ap parsed_array
# CSV.open(ORDERS_CSV, 'r')
#   file.each do |line|
#     orders_array << line
#     parsed_array = []
#     orders_array.each_with_index do |order, i|
#       parsed_array[i] = []
#       parsed_array[i][0] = order[0].to_i
#       parsed_array[i][1] = Hash[order[1].split(/:|;/).each_slice(2).collect{ |k,v| [k,v] }]
#     end
#   return parsed_array
#   end
# end

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |name, price|
        subtotal += price
      end
      total = (subtotal * 1.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all(csv_file=FILE_NAME)
      csv_array = CSV.read(csv_file, 'r')
      all_orders = []
      csv_array.each do |order|
        id = order[0].to_i
        products = Hash[order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
        new_order = Order.new(id, products)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(id, csv_file=FILE_NAME) #uses FILE_NAME by default if a different file isn't given
      Order.all(csv_file).each do |object|
        if object.id == id
          return object
        end
      end
      return nil
    end
  end
end
