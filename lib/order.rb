require "csv"
require "awesome_print"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      result = 0
      @products.each_value do |value|
        result += value
      end
      result = result + (result * 0.075)
      return result.round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.read("support/orders.csv", 'r').each do |order|
        id = order[0].to_i
        product_hash = {}
        order[1].split(";").each do |product|
          product_array = product.split(":")
          product_hash[product_array[0]] = product_array[1].to_f
        end
        all_orders << self.new(id, product_hash)
      end
      all_orders
    end

    def self.find(id)
      requested_order = nil
      self.all.each do |order|
        if order.id == id
          requested_order = order.products
        end
      end
      return requested_order
    end
  end
end
# Running Wave 1
# firstOrder = Grocery::Order.new(1, {"Slivered Almonds"=>22.88, "Wholewheat flour"=>1.93, "Grape Seed Oil"=>74.9})
#   ap firstOrder.total
#   ap firstOrder.remove_product("Slivered Almonds")
#   ap firstOrder
# Running Wave 2
   # ap Grocery::Order.all
  # self.find
  # ap Grocery::Order.find(80)
  # ap Grocery::Order.find(101)
