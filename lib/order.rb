require 'csv'
require 'awesome_print'


module Grocery


  class Order
    attr_reader :id, :products, :original_array, :hash, :data


    def initialize(info)
      @id = id
      @info = info

    def return_list
      order_list = {}
      @order_list = order_list
      @info.each do |row|
        order_id = row[0]
        products = row[1]
        products = products.split(';')

        products.each do |item|
          item = item.split(':')
          @order_list[item[0]] = item[1]
        end
      end
      print @order_list
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
end


data = CSV.read("../support/orders.csv")

first_try = Grocery::Order.new(data)
first_try.return_list
