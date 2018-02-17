require "csv"
require "ap"

module Grocery
  class Order
    attr_accessor :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum =   @products.values.sum
      return sum + (sum * 0.075).round(2)
    end

    def add_product (product_name, product_price)
      if @products.keys.include?(product_name) != true
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end
    #"Returns an array of all orders"
    def self.all
      data_array = CSV.read("support/orders.csv", "r")
      orders = []
      data_array.each do |order|
        products_hash = {}
        order[1].split(';').each do |product|
          array_product_price = product.split(":")
          products_hash[array_product_price[0]] = array_product_price[1]
        end
        orders <<   Order.new(order[0],products_hash)
      end
      return orders
    end

    def self.find(id_number)
      orderlist =  self.all
      the_order = nil
      orderlist.each do |order|
        if order.id == id_number
           the_order = order
        end

      end
      return the_order
    end
  end
end
