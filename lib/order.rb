require 'csv'
require 'awesome_print'

module Grocery
  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # Return the total cost of an Order instance
    def total
      subtotal = 0
      @products.each do |key, value|
        subtotal += value
      end

      total = subtotal * (1 + 0.075)
      return total.round(2)
    end

    # Add product name and price to @products of an Order instance
    def add_product(product_name, product_price)
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

    # Remove a product from @products of an Order instance
    def remove_product(product_name)
      before_count = @products.length
      if !@products.keys.include?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

    # Return an array of Order instances
    def self.all
      return Order.parse_csv
    end

    # Helper method to parse CSV file into an array of Order instances
    def self.parse_csv
      arr_of_arrs = CSV.read('support/orders.csv')
      orders = []
      arr_of_arrs.each do |row|
        product_string = row[1].split(";")
        product_hash = product_string.map do |x|
          x = x.split(":")
          Hash[x.first, x.last.to_f]
        end
        product_hash = product_hash.reduce(:merge)

        id = row[0].to_i
        products = product_hash
        orders << Order.new(id, products)
      end
      return orders
    end

    # Return @products of an Order instance searched by order id
    def self.find(id)
      orders = Order.all
      orders.each do |order|
        if order.id == id
          return order.products
        end
      end
      return nil
    end

  end
end
