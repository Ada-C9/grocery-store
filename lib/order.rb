require 'csv'
require 'awesome_print'


module Grocery

  class Order
    attr_accessor :id, :products, :items, :item_and_price_hash, :product_name, :product_price, :order_items, :order_number

    def initialize(id, products)
      @id = id
      @id = @id
      @products = products
      @item_and_price_hash = item_and_price_hash
      puts "Order: #{@id}: Products: #{@products}"
    end

    def receipt
      puts "Your purchases:"
      @products.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def create_hash_values
      @item_and_price_hash = item_and_price_hash
      @item_and_price_hash = {}


       @products = @products.split(',')
       ap @order_items

       @products.each do |item|
          item = item.split(':')
          @item_and_price_hash[item[0]] = item[1]
        end
      @products = @item_and_price_hash
      puts "This is order:#{@id} with the items #{@products}"
      puts @products
      return @products
    end


    # def self.all(whatever)
    #   order_list = {}
    #   @order_list = order_list
    #   final = {}
    #   @final = final


    #   @info.each do |row|
    #     order_id = row[0]
    #     products = row[1]
    #     products = products.split(';')
    #     final[order_id] = [products]
    #     ap products

    #     products.each do |item|
    #       item = item.split(':')
    #       @order_list[item[0]] = item[1]
    #     end
    #   end
    #   ap @order_list
    #   ap @final


    # end

    def total
      if @products.empty?
        return 0
      end

      total = 0
      tax = 0.075
      @products.each do |item, price|
        total += price.to_f
      end
      total = total + (total * tax)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_f
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


first_order = Grocery::Order.new(1, "apple:1.00,orange:3.00,grapes:2.50")
ap first_order
first_order.create_hash_values
ap first_order.total
first_order.add_product("strawberry", 7.56)
ap first_order
first_order.receipt
#

# data = CSV.read("../support/orders.csv")

# first_try = Grocery::Order.new(data)
# Grocery::Order.all(data)
# first_try = Grocery::Order.new(data)

# test_order = Grocery::Order.new(001, ["apple", "orange", "pear"])
# ap test_order
# test_order.total
