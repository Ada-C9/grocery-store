require 'csv'
require 'awesome_print'

module Grocery
  TAX = 0.075

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # Returns the total cost of all products (including tax)
    def total
      subtotal = 0
      @products.each do |key, value|
          subtotal += value
      end
      return (subtotal * (1 + TAX)).round(2)
    end

    def add_product(product_name, product_price)
      # Checks if the products hash contains product_name
      if @products.has_key?(product_name)
        return false
      else
        # Adds product_name & product_price to @products
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name, product_price)
      # Checks if product exists
      if @products.has_key?(product_name) == false
        return false
      else
        # Deletes product if it exists
        @products.delete(product_name)
        return true
      end
    end

    def self.all
      list = []
      CSV.read("support/orders.csv", 'r').each do |row|
        list << row
      end

      # Iterates through list array and parses out the order id and products
      all_csv_orders = []
      list.each do |row|
        groceries = []
        products = row[1].split(";")
          products.each do |item|
            # Converts from one strings to hash with float values
             groceries << item.split(":")
             products = groceries.to_h
             products.each {|key,val| products[key] = val.to_f}
          end
        id = row[0].to_i
        # Creates a new order from parsed data. Adds single order to Orders array
        new_order_class = Order.new(id, products)
        all_csv_orders << new_order_class
      end

      #returns a collection(array) of Order instances
      return all_csv_orders
    end

    # Iterates through array of Order instances and searches by order_id
    def self.find(order_id)
      all_orders = Order.all
      all_orders.each do |one_order|
        if one_order.id == order_id
          return one_order
        end
      end
      return nil
    end

  end
end
