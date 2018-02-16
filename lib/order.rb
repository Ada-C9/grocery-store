require 'csv'
require 'awesome_print'

ORDERS_CSV = 'support/orders.csv'

orders_array = CSV.read(ORDERS_CSV, 'r')
parsed_array = []
orders_array.each_with_index do |order, i|
  parsed_array[i] =[]
  parsed_array[i][0] = order[0].to_i
  parsed_array[i][1] = Hash[order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
end

ap parsed_array
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

    # def self.all
    #
    # end
  end
end

order_1 = Grocery::Order.new(parsed_array[0][0],parsed_array[0][1])
puts "The order total is #{order_1.total}"
