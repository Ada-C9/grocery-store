require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = 0
      # loop that adds each product value to subtotal
      @products.each do |key, value|
          subtotal += value
      end
      # returns the (subtotal + tax) and rounds to two decimals
      return (subtotal * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      #checks if the products hash contains product_name
      if @products.has_key?(product_name)
        return false
      else
        #adds product_name & product_price to @products
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name, product_price)
      if @products.has_key?(product_name) == false
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

    def self.all
      list = []
      CSV.read("support/orders.csv", 'r').each do |row|
        list << row
      end

      grocery_list = []
      # list.first(2).each do |row|
      list.each do |row|
        groceries = []
        products = row[1].split(";")
          products.each do |item|
             groceries << item.split(":")
             products = groceries.to_h
             products.each {|key,val| products[key] = val.to_f}
          end
        id = row[0].to_i
        order = [id, products]
        grocery_list << order
      end

      all_csv_orders = []
      grocery_list.each do |line|
        id = line[0]
        products = line[1]
        new_order_class = Order.new(id, products)
        all_csv_orders << new_order_class
      end

      #returns a collection(array) of Order instances
      return all_csv_orders
    end

    def self.find(order_id)
      # ap "The id is #{id}"
      all_orders = Order.all
      # ap all_orders[id]
      all_orders.each do |one_order|
        if one_order.id == order_id
          return one_order
        end
      end
      return nil
    end

  end
end

# order = Grocery::Order.find(1)
# ap order

# orders = Grocery::Order.all
# # ap orders
#
# orders.each do |one_order|
#   if one_order.id == 24
#     ap one_order
#   else
#     ap "nil"
#   end
# end


# list = []
# CSV.foreach("../support/orders.csv") do |row|
#   list << row
# end

# CSV.open("../support/orders.csv", 'r').each do |row|
#   list << row
# end
#
# grocery_list = []
#
# list.first(3).each do |row|
#   groceries = []
#   products = row[1].split(";")
#     products.each do |item|
#        groceries << item.split(":")
#        ap groceries
#        products = groceries.to_h
#        products.each {|key,val| products[key] = val.to_f}
#     end
#   id = row[0].to_i
#   order = [id, products]
#   grocery_list << order
# end
# # ap grocery_list
# grocery_list.each do |line|
#   id = line[0]
#   products = line[1]
#   ap id
#   ap products
# end

# ap grocery_list[0][0]
# ap grocery_list[0][1]
