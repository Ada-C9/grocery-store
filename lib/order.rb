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
      return Order.parse_csv
    end

    # Helper method to convert strings in array to hashes
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
