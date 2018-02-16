require 'csv'
require 'awesome_print'


FILE_NAME = "../support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
    end

    def self.all
      all_orders = []

      CSV.open(FILE_NAME, "r").each do |line|
        # all_orders << line # original to test if it would open/what printed
        id = line[0].to_i
        products = {}
        product_array = line[1].split(";") #separates prods in order into array
        product_array.each do |item|
          split_item = item.split(":")
          product_name = split_item[0]
          product_price = split_item[1].to_f
          products[product_name] = product_price
        end
        all_orders << self.new(id, products)
      end
      return all_orders
    end

    def self.find(id)
      self.all.each do |order|
        return order if order.id == id
      end
    end

    def total
      # TODO: implement total
      sub_total = 0.00
      @products.each do |product, cost|
        sub_total += cost
      end
      # return sub_total

      @total = sub_total + (sub_total * @tax)
      return @total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.key?(product_name) #method to see if the product already exists in product hash
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end

# ap Grocery::Order.all
ap Grocery::Order.find(6)
# my_order = Grocery::Order.new(1,[{"Slivered Almonds" => 22.88},{"Wholewheat flour" => 1.93},{"Grape Seed Oil" => 74.9}])
# puts my_order
# puts Grocery::Order.all
