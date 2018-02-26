require "csv"
# require_relative "../support/orders.csv"
require "awesome_print"
require "pry"

module Grocery

  class Order

    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        total = 0
      end
      subtotal = @products.values.inject(0, :+)
      total = subtotal + (subtotal * 0.075).round(2)
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
      all_orders = []
      CSV.read('support/orders.csv', 'r').each do |row|
      # CSV.read('../support/orders.csv', 'r').each do |row|
        row.each do
          @id = row[0].to_i
          split_rows = row[1].split(";")
          keys_values = split_rows.map {|item| item.split /\s*:\s*/ }
          @products = Hash[keys_values]
        end
        all_orders << Grocery::Order.new(@id, @products)
      end
      return all_orders
    end

    # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
    def self.find(id)
      all_orders = Grocery::Order.all
      #.find_all returns an array, containing the one instance of Order where the id matches the passed parameter
      order_instance = all_orders.find_all { |order| order.id == id }
      if order_instance.length <= 0
        return nil
      else
        return order_instance
      end
    end
  end
end
