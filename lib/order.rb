require 'csv'
require 'awesome_print'

module Grocery


  class Order
    attr_reader :id, :products, :original_array, :hash

    def initialize(parameter)
      @id = id
      @hash = {}
      @hash = Hash[parameter.map {|x| [x[0], x[1..-1]]}]
    end

    def total
      if @products.empty?
        return 0
      end

      total = 0
      tax = 0.075
      @products.each do |item, price|
        total += price
      end
      total = total + (total * tax)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_i
      if @products.has_key? @product_name
        return false
      else
      @products[@product_name] = @product_price
      return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
      else
        puts "Product is not on this order."
      end
    end
  end
end

array_of_orders_data = CSV.open("../support/orders.csv", 'r')


dinner = Grocery::Order.new(array_of_orders_data)
