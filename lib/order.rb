require 'csv'

module Grocery
  class Order
    attr_reader :id, :products
    # class variable for orders
    def initialize(id, products)
      @id = id.to_i
      @products = products
    end
    # Class method that will allow up to return a collection of Order instances, represents orders described in CSV file
    # array to hold the orders file information
    def self.all
      # Open this shit
      file = CSV.open("support/orders.csv", "r")
      # Loop through each line in CSV file and add it to the array orders
      all_orders = []
      file.each do |line|
        # each line has fields separated by semi-colons, so split those fields. This tells us what the separaters are (';')
        id = line[0]
        raw_products = line[1]
        products_1 = raw_products.split(";")
        # puts "#{id}: #{raw_products}"
        products_2 = []
        products_1.each do |string|
          products_2 << string.split(":")
        end
        final_products = {}
        products_2.each do |product|
          final_products[product[0]] = product[1]
        end
        all_orders << Order.new(id,final_products)
      end
      return all_orders
    end

    def self.find(id)
      all_orders = Grocery::Order.all
      all_orders.each do |order|
        if all_orders.find(id) == id
          return order
        end
        if all_orders.find(id) != id
          return " That ID is not in our orders."
        end
      end
    end
    # Instance methods: allowing me to initialize an order,
    # total up the prices of the order that was created (including sales tax)
    # add a product to the order list
    def total
      sum = 0
      total_sum = 0
      products.each_value do |value|
        sum += value
        total_sum = sum + (sum * 0.075).round(2)
      end
      return total_sum
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      end
      @products[product_name] = product_price.to_i
      return true
    end
  end
end
