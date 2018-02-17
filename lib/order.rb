require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    # @@orders = []
    # @@instance_of_order = []

    def initialize(id, products)
      @id = id
      @products = products
      # @@orders << [@id, @products]

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

      orders = []

      CSV.read('support/orders.csv', 'r', header_converters: :symbol ).each do |line|
        groceries = []
        products = line[1].split(';')
        products.each do |items|
          groceries << items.split(':')
          products = groceries.to_h
          products.each {|key, val| products[key] = val.to_f}
        end

        orders << Grocery::Order.new(line[0], products)
      end

      return orders
    end

    def self.find(id)
      return all.find { |order| order.id == id }
    end

  end
end

# puts "Find id 1: #{Grocery::Order.find(1)}"

# DONE
# ap orders
# Grocery::Order.all

ap Grocery::Order.find("7")
