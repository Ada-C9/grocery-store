require 'csv'
require 'awesome_print'



module Grocery
  class Order
    attr_reader :id, :products, :product_name, :product_price

    @@order_list = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end

      total =  (subtotal + (subtotal * 0.075)).round(2)
    end

    def add_product(product_name, product_price)

      if @products.keys.include?(product_name)
        return result = false
        puts "#{@products[product_name]} was already in your cart"
      else
        @products[product_name] = product_price
        return result = true
        puts "#{@products[product_name]} added to your cart"
      end
    end

    def self.all
      # class method, read from csv, retrun list of orders
      CSV.read('../support/orders.csv').each do |line|
        @@order_list << line
        return @@order_list
      end
      @@order_list[]
      @@order_list.each do |item|
        @@order_list[item] << { id:  line[0] }
        # line[1].split(';')

        # products:  item[1]
      end
    end

    def self.find
      # will take one parameter (an ID), returns one order from the CSV, return nil if ID not found
    end

  end
end
