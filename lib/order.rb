#Lily Sky Grocery Store - Order
#Ada C9

require 'awesome_print'
require 'csv'


module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def total
      sum = 0
      @products.each_value do |value|
        sum += value.to_f
      end

      total = (sum * 1.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete_if {|key, value| key >= product_name}
        return true
      else
        return true
      end
    end

    def self.all_orders
      orders = []
      CSV.read("support/orders.csv").each do |line|
        sorted_list = line[1].split(";")
        sorted_list_2 = []

        sorted_list.each do |pair|
          sorted_list_2 << pair.split(":")
        end

        products = sorted_list_2.to_h
        orders << Grocery::Order.new(line[0], products)
      end
        return orders
    end

    def self.find_order(id)
      Order.all_orders.each do |item|
        if item.id == id
        return item
        end
      end
      return nil
    end



  end

  # ap Order.all_orders[0]
  # ap Order.all_orders
  # ap Order.find_order("200")
    # ap Order.all_orders







end
