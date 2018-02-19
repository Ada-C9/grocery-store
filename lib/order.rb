require 'csv'

ORDERS = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    # param id - order id (integer)
    # param products - {} of products and costs
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total_price = 0
      tax_rate = 0.075
      @products.each_value do |price|
        total_price += price * (1 + tax_rate)
      end
      return total_price.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Create a remove_product method to check if a product is removed
    def remove_product(product_name)
      if @products.keys.include?(product_name)
        return false
        @products.keys.delete(product_name)
      else
        return true
      end
    end

    # Create self.all method to read csv files
    def self.all
      csv_orders = []
      CSV.read(ORDERS, "r").each do |order|
        # id
        id = order[0].to_i
        # products - hashes
        order_row = order[1].split(%r{;\s*}) # Now it's an array of string
        # Split again to get two strings seperate
        product_hash = {}

        order_row.each do |product|
          pairs = product.split(%r{:\s*}) # an array of two string - key & value
          # Store the key value pair in a new hash - which refers to one product
          product_hash[pairs[0]] = pairs[1].to_f
        end

        product = product_hash
        csv_orders << Order.new(id, product)
      end # CSV read method ends

      return csv_orders
    end # self.all method ends

    # Create a self.find method
    def self.find(id)
      correct_order = nil
      self.all.each do |each_order|
        if each_order.id == id
          correct_order = each_order
        end
      end

      if correct_order != nil
        return correct_order
      else
        ArgumentError
      end

    end # self.find method ends

  end # class Order ends

end # module Grocery ends
