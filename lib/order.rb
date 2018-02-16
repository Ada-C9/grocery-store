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
      @products.each do |key, value|
        subtotal += value
      end
      total = subtotal * (1 + 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      before_count = @products.length
      if @products.keys.include?(product_name)
        return false
      end
      @products[product_name] = product_price
      if @products.length == before_count + 1
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      # TODO: implement remove_product
      before_count = @products.length
      if !@products.keys.include?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

    def self.all
      # Read contents of file into array of arrays
      # csv_array = CSV.read('support/orders.csv')
      csv_array = CSV.read('support/less_orders.csv')

      orders = []
      csv_array.each do |row|
        # Convert products string into Hash
        product_string = row[1].split(";")
        product_hash = product_string.map do |x|
          x = x.split(":")
          Hash[x.first, x.last.to_f]
        end
        product_hash = product_hash.reduce(:merge)

        # Create new order and push into orders
        id = row[0].to_i
        products = product_hash
        orders << Order.new(id, products)
      end
      return orders
    end

    def self.find(id)
      orders = Order.all
      orders.each do |entry|
        if entry.id == id
          return entry.products
        end
      end
      return "Error: this order doesn't exist!"
    end

  end
end
