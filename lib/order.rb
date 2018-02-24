require 'csv'
require 'awesome_print'
require 'pry'

FILE_NAME = "support/orders.csv"

# data = CSV.read(FILE_NAME)
# ap data
#
# data.each do |product|
#   puts " Product #{product[0]}: #{product[1]}"
# end

# CSV.open(FILE_NAME, 'r').each do |product|
# #  file.each do |product|
#     puts " Product #{product[0]}: #{product[1]}"
# #  end
# end

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # def total
    #   sum = products.values.inject(0, :+)
    #   total = sum + (sum * 0.075).round(2)
    #   return total
    # end

    def total
      sum = 0
      total = 0
      @products.each_value do |price|
        sum += price
      end
      return total = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end



    def self.all
      orders = []
      CSV.read("support/orders.csv").each do |row|
        # row looks like ["123", "Eggs:3.00;Milk:4.50"]
        # let's tackle id first
        id_string = row[0]
        id = id_string.to_i
        # let's tackle the products
        products_string = row[1]
        products_array = products_string.split(";")
         # let's loop inside products_array
         products_hash = {}
         products_array.each do |product|
           product_pair = product.split(":")
           product_name = product_pair[0]
           product_price = product_pair[1].to_f
           # now we put it into a hash
           products_hash[product_name] = product_price
         end
         order = Order.new(id, products_hash)
         orders << order
      end
      return orders
    end

    def self.find(id)
      order_id = nil
      self.all.each do |order|
        if order.id == id
          order_id = order
        end
      end
      if order_id == nil
        return nil
      else
        return order_id
      end
    end
  end
end




ap Grocery::Order.all
#   puts " Product #{product[0]}: #{product[1]}"
#   products << Order.new(product[0], product[2])
# end
