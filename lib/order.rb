require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    @@orders = []

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

      CSV.read('support/orders.csv', 'r').each do |line|
        groceries = []
        line[0] = line[0].to_i
        products = line[1].split(';')
        products.each do |items|
          groceries << items.split(':')
          products = groceries.to_h
          products.each {|key, val| products[key] = val.to_f}
        end

        @@orders << Grocery::Order.new(line[0], products)

      end

      return @@orders
    end

    def self.find(id)
      find_result = all.find { |order| order.id == id }
      if find_result == nil
        return "Error: Order ID does not exist"
      else
        return find_result
      end
    end

  end
end

# puts "Find id 1: #{Grocery::Order.find(1)}"

# DONE
# ap orders
# ap Grocery::Order.all
#
# ap Grocery::Order.find("1")
# ap Grocery::Order.all[0]

# ap Grocery::Order.find("112")
# ap Grocery::Order.find("1")
# first_order = Grocery::Order.all[0]
# ap first_order.add_product("salad", 4.25)
# ap first_order
