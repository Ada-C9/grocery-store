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
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      sum_with_tax = (0.075 * sum + sum).round(2)
      return sum_with_tax
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

  # must add tests for this function
    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      orders_entered = []
      CSV.read("../support/orders.csv").each do |row|
        id = row[0].to_i
        products = {}
        products_array = row[1].split(";")

        products_array.each do |item|
          name, price = item.split(':')
          products[name] = price.to_f
        end
        orders_entered << Order.new(id, products)
      end
      return orders_entered
    end

    def self.find(id)
      orders_entered = self.all
      orders_entered.each do |order|
        if order.id == id
          return order
        end
      end
      return nil
    end

  end
end
