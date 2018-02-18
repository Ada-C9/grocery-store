require 'csv'
require 'awesome_print'

FILE_NAME = 'support/orders.csv'

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def total
      ((@products.values.sum) * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include? (product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include? (product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.open(FILE_NAME, 'r').each do |order|
        id = order[0].to_i
        products = {}
        produce = order[1].split(";")
        produce.each do |items|
          pair = items.split(":")
          keys = pair[0]
          value = pair[1].to_f
          products[keys] = value
        end

        new_order = Order.new(id, products)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(id)
      array_ids = []
      all_orders = Grocery::Order.all
      all_orders.each do |arr|
        array_ids << arr.id
        if array_ids.include? id
          return Order.new(arr.id, arr.products)
        end
      end
      return NIL
    end
  end
end
