require 'csv'
require 'awesome_print'

# orders = []
#
# CSV.read("../support/orders.csv").each do |order|
#   orders << order
# end

# ap orders

module Grocery
  class Order
    attr_reader :id, :products

    @@all_orders = []

    def initialize(id, products)
      @id = id
      @products = useful_data(products)
    end

    def useful_data(grouped_data)
      if grouped_data.class == String
        grouped_products = grouped_data.split(";")
        product_pairs = {}
        grouped_products.each do |grouped_item|
          separated_item = grouped_item.split(":")
          product_pairs[separated_item[0]] = separated_item[1].to_f.round(2)
        end
        product_pairs
      elsif grouped_data.class == Hash
        grouped_data
      end
    end

    def total
      # TODO: implement total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075)
      total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products[product_name]
        false
      else
        @products[product_name] = product_price
        true
      end
    end

    def remove_product(product_name)
      @products.delete(product_name)
      if @products[product_name]
        false
      else
        true
      end
    end
    def self.all
      @@all_orders = []
      CSV.read("support/orders.csv").each do |order|
        an_order = self.new(order[0].to_i, order[1])
        @@all_orders << an_order
      end
      @@all_orders
    end

  end
end


# ap Grocery::Order.all

# experimenting with csv data and formatting
# def making_usable_orders(grouped_orders)
#   separated_orders = []
#   grouped_orders.each do |grouped_order|
#     grouped_items = grouped_order[1].split(";")
#     separated_items = {}
#     grouped_items.each do |grouped_item|
#       separated_item = grouped_item.split(":")
#       separated_items[separated_item[0]] = separated_item[1]
#     end
#     order = Grocery::Order.new(grouped_order[0], separated_items)
#     separated_orders << order
#   end
#   separated_orders
# end
####
# organized_orders = making_usable_orders(orders)
#####
# ap organized_orders

# random_orders = [[1, "Slivered Almonds:22.88;Wholewheat flour:1.93;Grape Seed Oil:74.9"],
# [2, "Albacore Tuna:36.92;Capers:97.99;Sultanas:2.82;Koshihikari rice:7.55"],
# [3, "Lentils:7.17"]]
#
# testing_class_initialize = []
# random_orders.each do |order|
#   new_order_instance = Grocery::Order.new(order[0], order[1])
#   testing_class_initialize << new_order_instance
# end
#
# ap testing_class_initialize
