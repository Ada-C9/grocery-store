require "csv"
require "awesome_print"

ORDERS_CSV = "../support/orders.csv" # take off ../ if running rake

module Grocery

  class Order
    attr_reader :all, :total
    attr_accessor :id, :products, :add_product

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      orders = []
      csv = CSV.read(ORDERS_CSV, "r")

      csv.each do |row|
        products_hash = {}
        id = row[0].to_i
        products_string = row[1].split(";")

        products_string.each do |product| # "cucumber:5"
          key = product.split(":")[0] # ["cucumber", "5"]
          value = product.split(":")[1]
          products_hash[key] = value.to_f # or # products_hash.push(key: value)
        end
        orders << Order.new(id, products_hash) # shovel the sliced order into the global orders array
      end

      return orders # if return not here, the program returns what the .each
      ############### method is called on, which is the csv file
    end

    def self.find(id)
      # is this method dependent on the .all method? sure, it's an incoming msg
      all.each do |order|
        # if order.id == id
        #   return order.products
        # else
        #   return []
        # end
        # raise ArgumentError.new("Order number could not be found")
        unless order.id == id
          raise ArgumentError.new("Order number could not be found")
        end
        return order.products
      end # the iterator
    end # self.find

    def total
      # to do: implement total
      sum = @products.values.inject(0, :+)
      after_tax = sum + (sum * 0.075).round(2)
      # @products.each_value do |product_price|
      #   total += product_price
      # end
      # after_tax = (total * 0.075 + total).round(2)
      return after_tax
    end

    def add_product(product_name, product_price)
      # you weren't testing the key, you were testing both
      if @products.key? product_name
        puts "This is already included in the order."
        return false
      else
        @products.store(product_name, product_price)
        return true
      end # if statement
    end # add_product

  end # class Order
end # module Grocery

first_order = Grocery::Order.all[0]
puts first_order.id
puts "Order number is: #{first_order.id} and order includes #{first_order.products}"

# all_orders = Grocery::Order.all
# puts "#{all_orders}"

# orders = Grocery::Order.all
# puts orders.add_product("juice",2)

# find_order = Grocery::Order.find(99) #this is not working after adding error handling
# puts "This order contains #{find_order}"
