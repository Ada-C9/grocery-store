require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    @@orders = []

    def initialize(id, products)
      @id = id
      @products = products
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
        raise ArgumentError.new("Order ID entered does not exist.")
      else
        return find_result
      end
    end

  end
end
