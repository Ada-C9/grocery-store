require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    @@all = 1
    @@instance_of_order = []

    def initialize(id, products)
      @id = id
      @products = products
      @@all += 1
      # @@instance_of_order = @products.id

    end

    def total

      if @products.length == 0
        return 0
      end

      sum = 0
      @products.each_value do |value|
        sum += value
      end
      total = sum + (sum * 0.075).round(2)
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

    def self.all
      return @@all
    end

    # def self.find(id)
    #   @id = id
    #
    #
    # end

  end
end

# order_1 = [1, { "Silvered Almonds" => 22.88 } ]
#
# first_order = Grocery::Order.new(order_1[0], order_1[1])
#
# print first_order

headers = ["id", "products", "product_name", "product_price"]

orders = []


CSV.read('../support/orders.csv', 'r', headers: true, header_converters: :symbol ).each do |line|
  groceries = []
  products = line[1].split(';')
  products.each do |items|
    groceries << items.split(':')
    products = groceries.to_h
    products.each {|key, val| products[key] = val.to_f}
  end

  orders << Grocery::Order.new(line[0], products)
end

#.to_h to convert to a hash

puts "Total orders = #{Grocery::Order.all}"

# puts "Find id 1: #{Grocery::Order.find(1)}"

ap orders
