require "csv"
# require_relative "../support/orders.csv"
require "awesome_print"
require "pry"

module Grocery

  class Order

    @@all_orders = []

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        total = 0
      end
      # I still dont full understand what .inject(0, :+) is doing but pretty sure it is iterating through @products array, injecting a + operater in between each elements therefore adding them together?
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
      @@all_orders = []
      CSV.read('support/orders.csv', 'r').each do |row|
      # CSV.read('../support/orders.csv', 'r').each do |row|
        row.each do
          @id = row[0].to_i
          split_rows = row[1].split(";")
          # ap split_rows
          keys_values = split_rows.map {|item| item.split /\s*:\s*/ }
          @products = Hash[keys_values]
          # ap prod_hash
        end
        @@all_orders << Grocery::Order.new(@id, @products)
      end
      return @@all_orders
    end

    # self.find(id) - returns an instance of Order where the value of the id field in the CSV matches the passed parameter.
    # Return nil if order can't be found... write tests for this. Write test to find first order, last order, etc...
    def self.find(id)

      @@all_orders = Grocery::Order.all
      #.find_all returns an array, containing the one instance of Order where the id matches the passed parameter
      order_instance = @@all_orders.find_all { |order| order.id == id }
      if order_instance.length <= 0
        return nil
      else
        return order_instance
      end
    end
  end
end

# ap Grocery::Order.find(33)
# ap Grocery::Order.all[0].id
# all_orders =
# orders = Grocery::Order.all
# ap orders
# print all_orders
# all_orders = []

#
# ap all_orders.count

# In future wave of grocery store I could use a subclass to do something like... add a shipping fee for example

# WAVE 3

# overwrite total and add_product methods to extend them and add certain things
# OnlineOrder will also have its own class methods, which will completely overwrite the parent class's class methods
