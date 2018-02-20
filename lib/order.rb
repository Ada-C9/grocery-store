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
      ((@products.values.sum)*1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all
      all_orders = []
      CSV.open(FILE_NAME, 'r').each do |num|
        new_item_hash = {}
        id = num[0].to_i
        num[1].split(";").each do |item|
          new_item = item.split(":")
          key = new_item[0]
          value = new_item[1].to_f
          new_item_hash[key] = value
        end
        new_order = Order.new(id, new_item_hash)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(good_id)
      return_value = "Sorry, that order is not in our records"
      self.all.each do |order|
        if order.id == good_id
          return_value = order
        end
      end
      return return_value
    end

  end
end

ap Grocery::Order.find(19999)
