require 'csv'
require 'awesome_print'

FILE_NAME = "../support/orders.csv"
#  FILE_NAME = "support/orders.csv"

module Grocery

  class Order
    attr_accessor :id, :array, :all_orders, :csvarray, :products, :items, :item_and_price_hash, :product_name, :product_price, :order_items, :order_number

    def initialize(id, products)
      @id = id
      @products = products
      @array = [@id, @products]
      # return @array
      @item_and_price_hash = item_and_price_hash
      @item_and_price_hash = {}

      # @order_number = @products[@id][0]
      #  @order_items = @products[@id][1]
       @order_items = @products.split(';')

       @order_items.each do |item|
          item = item.split(':')
          @item_and_price_hash[item[0]] = item[1]
        end
      # puts "This is order:#{@id} with the items #{@order_items}"
      # # puts @order_items
      # print @item_and_price_hash
      # return @item_and_price_hash
    end


    def self.all(whatever)
      @all_orders = []
      whatever.each do |row|
        order = Grocery::Order.new(row[0], row[1])
        @all_orders << order
        # puts order.receipt
      end
        n = 1
       @all_orders.each do |index|
         puts "\n\nORDER #{n}:"
         index.receipt
         print "TOTAL: "
         puts index.total
         n += 1
       end
    end

    def self.find(id)
      if @all_orders.include?(@all_orders[id - 1])
        @all_orders[id - 1].receipt
        puts "Total: #{@all_orders[id - 1].total}"
      else
        puts "That order does not exist."
      end
    end


    def receipt
      puts "RECEIPT:"
      @item_and_price_hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end


    def total
      if @products.empty?
        return 0
      end

      total = 0
      tax = 0.075
      @item_and_price_hash.each do |item, price|
        total += price.to_f
      end
      total = total + (total * tax)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_f
      if @item_and_price_hash.has_key? @product_name
        return false
      else
        @item_and_price_hash[@product_name] = @product_price
        return @item_and_price_hash
      end
    end

    def remove_product(product_name)
      if @item_and_price_hash.has_key?(product_name)
        @item_and_price_hash.delete(product_name)
      else
        puts "Product is not on this order."
      end
    end
  end

  class OnlineOrder < Order
    attr_reader :customer_id
    attr_accessor :status

    def initialize(id, products, customer_id, status = :pending)
      super(id, products)
      @customer_id = customer_id
      @status = status
      if @status == nil
         @status = :pending
      else
        @status = status.to_sym
      end
    end

    def total
      puts "*$10 SHIPPING FEE HAS BEEN ADDED*"
      return super + 10
    end

    def add_product(product_name, product_price)
      @product_name = product_name
      @product_price = product_price.to_f
      if
        @item_and_price_hash.has_key? @product_name
        return false
      elsif
        @status == :pending || @status == :paid
        @item_and_price_hash[@product_name] = @product_price
        return @item_and_price_hash
      else
        puts "ORDER CANNOT BE ADJUSTED"
        return false
      end
    end
  end
end

test_online_order = Grocery::OnlineOrder.new(200, "apple:1.34;orange:3.40;pear:6.00", "C43")
ap test_online_order
puts test_online_order.total
test_online_order.add_product("peach", 3.99)
puts test_online_order.total



#
#
# data = CSV.read(FILE_NAME)
# puts "ALL THE ORDERS IN THIS COLLECTION:"
# Grocery::Order.all(data)
#
# puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
# finder_response = gets.chomp.upcase
#
# while finder_response != "NO"
#   if finder_response == "YES"
#     puts "\nWHICH ORDER WOULD YOU LIKE TO RETRIEVE?"
#     retreiver_number = gets.chomp.to_i
#     puts "\n****ORDER ##{retreiver_number}****"
#     Grocery::Order.find(retreiver_number)
#     puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
#     finder_response = gets.chomp.upcase
#   else
#     puts "THAT IS AN INVALID SELECTION"
#     puts "\n\nWOULD YOU LIKE TO LOOK UP AN ORDER? (YES/NO)"
#     finder_response = gets.chomp.upcase
#   end
# end
# exit
