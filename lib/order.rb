require 'csv'
require 'awesome_print'
require 'pry'


module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.each do |k, v|
        total += v
      end
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)

      if @products.key? product_name
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end


    def self.all
      all_orders = []
      CSV.read("../support/orders.csv").each do |order| # order - array

        products_hash = {}
        products_split = order[1].split(';')

        # products_split - array of product/ price
        products_split.each do |pair|
          split = pair.split(':')
          products_hash[split[0]] = split[1].to_f
        end

        new_order = self.new(order[0], products_hash)
        all_orders << new_order
      end
      return all_orders
    end
  end
end


 
