#Lily Sky Grocery Store - Online Order
#Ada C9

require 'awesome_print'
require 'csv'
require_relative 'order'
require_relative 'customer'

# 1, Lobster:17.18; Annatto seed:58.38; Camomile:83.21, 25, complete

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      sum = 0
      @products.each_value do |value|
        sum += value.to_f
      end
      if sum > 0
        shipping = 10.0
        total = shipping + (sum * 1.075).round(2)
        return total
      end
      return nil
    end

    def add_product(status)
      if [:processing, :shipped, :complete].include?@products.status
        return "invalid"
      else
        # @products[product_name] = product_price
        return "go"
      end
    end


    # def add_product(product_name, product_price)
    #   if @products.has_key?(product_name)
    #     return false
    #   else
    #     @products[product_name] = product_price
    #     return true
    #   end
    # end
    #
    # def remove_product(product_name)
    #   if @products.has_key?(product_name)
    #     @products.delete_if {|key, value| key >= product_name}
    #     return true
    #   else
    #     return true
    #   end
    # end
    #
    # def self.all_orders
    #   orders = []
    #   CSV.read("support/online_orders.csv").each do |line|
    #     sorted_list = line[1].split(";")
    #     sorted_list_2 = []
    #
    #     sorted_list.each do |pair|
    #       sorted_list_2 << pair.split(":")
    #     end
    #
    #     products = sorted_list_2.to_h
    #     orders << Grocery::Order.new(line[0], products)
    #   end
    #     return orders
    # end
    #
    # def self.find_order(id)
    #   Order.all_orders.each do |item|
    #     if item.id == id
    #     return item
    #     end
    #   end
    #   return nil
    # end

  end

end
