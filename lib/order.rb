require 'csv'
require 'awesome_print'
#orders = []
# CSV.read('../support/orders.csv', 'r', headers: true,
#   header_converters: :symbol).each do |row|
#     ap row
# end
# data = CSV.read('../support/orders.csv',{ headers: true,
# header_converters: :symbols,converters: :all })
#   hashed_data = data.map { |d| d.to_hash }
#
#    #
#
# end
groceries_array = []

#CSV.read('../support/orders.csv', 'r', headers: true,
#   header_converters: :symbol).each do |row|
#     groceries << row
# end
# CSV.read('../support/orders.csv').each do |row|
#     groceries << row
# end
#
# groceries.each do |sub_array|
#    order_row << sub_array[1].split(",")
#
# end
#     order_row.each do |product|
#        grocery << product[0].split(";")
#
#      end
#
#    grocery.each do |row_val|
#      row_val.each do |row_val1|
#      key, val = row_val1.split(':')
#      grocery_hash[key] = val
#    end
#    end
#      ap grocery_hash







module Grocery
  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.each_values do |value|

        sum += value
        expected_total = sum + (sum * 0.7).round(2)
      end
      # TODO: implement total
      return expected_total
    end

    def self.all( groceries_array)
      CSV.read('../support/orders.csv').each do |row|
          groceries_array << row
      end
      #@id = id
      grocery = []
      order_row = []
      # product1 = []
      grocery_hash = {}
      grocery_array = []

         groceries_array.each do |sub_array|
         order_row << sub_array[1].split(",")

      end
          order_row.each do |product|
             grocery << product[0].split(";")

           end

         grocery.each do |row_val|
          row_val.each do |row_val1|
           key, val = row_val1.split(":")
           val = val.to_f
           grocery_hash[key] = val
          end
          grocery_array << grocery_hash
          grocery_hash = {}
         end
           return grocery_array


    end
    # def self.find(groceries_array)
    #   groceries_array.length.times do |i|
    #     id = i
    #   end
    #
    #   return id
    #
    #
    # end

    def add_product(product_name, product_price)
      # TODO: implement add_product

       #@products[:product_name] = product_price
       if @products.keys.include?(product_name)
         return false
       else
         return true
       end
    end
  end
end





  ap Grocery::Order.all(groceries_array)
  #Grocery::Order.find(groceries_array)

#ap Orders.all
