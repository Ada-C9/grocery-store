require 'CSV'
require 'awesome_print'


module Grocery

  class Order
    attr_accessor :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      ((@products.values.sum) * 1.075).round(2)
    end

    def add_product(product_name,product_price)
      @products = products

      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

    end

    def remove_product(product_name)
      if @products.keys.include? (product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end



    def self.all
      all_orders = []
      CSV.open('support/orders.csv', 'r').each do |order|
        product_hash = {}
        id = order[0].to_i
        order[1].split(";").each do |pair|
          new_pair = pair.split(":")
          key = new_pair[0]
          value = new_pair[1].to_f
          product_hash[key] = value
        end
        new_order = Order.new(id, product_hash)
        all_orders << new_order
        end
        return all_orders


    end
    def self.find(id)
      @id = id
      Grocery::Order.all.each do |order|
        if order.id == id
        return order
        end
      end
       raise  ArgumentError.new#("Id does not exists")


    end
  end
end

     ap Grocery::Order.all
    ap Grocery::Order.find(100)
     #ap Grocery::Order.all
#
#     # def self.find(passed_id)
#     #   self.all.each do |order|
#     #     if order.id == passed_id
#     #       return order
#     #     end
#     #     raise ArgumentError.new("Order with Id does not exist")
#     #   end
#     # end
#   end
# end
# # ap Grocery::Order.all
#  #ap Grocery::Order.find(30000)
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







# module Grocery
#   class Order
#
#     attr_reader :id, :products
#
#     def initialize(id, products)
#       @id = id
#       @products = products
#     end
#
#     def total()
#       @id = id
#       sum = 0
#       @products.each do |key,value|
#
#         sum += value
#         total1 = sum + (sum * 0.7).round(2)
#       end
#       # TODO: implement total
#       return total1
#     end

    # def self.all( groceries_array)
    #   CSV.read('../support/orders.csv').each do |row|
    #       groceries_array << row
    #   end
    #   #@id = id
    #   grocery = []
    #   order_row = []
    #   # product1 = []
    #   grocery_hash = {}
    #   grocery_array = []
    #
    #      groceries_array.each do |sub_array|
    #      order_row << sub_array[1].split(",")
    #
    #   end
    #       order_row.each do |product|
    #          grocery << product[0].split(";")
    #
    #        end
    #
    #      grocery.each do |row_val|
    #       row_val.each do |row_val1|
    #        key, val = row_val1.split(":")
    #        val = val.to_f
    #        grocery_hash[key] = val
    #       end
    #       grocery_array << grocery_hash
    #       grocery_hash = {}
    #      end
    #        return grocery_array
    #
    #
    # end
    # def self.find(groceries_array)
    #   groceries_array.length.times do |i|
    #     id = i
    #   end
    # Order.all.groceries_array.map{|i| i.id}
    #   return id
    #
    #
    # end

#     def add_product(product_name, product_price)
#       # TODO: implement add_product
#
#        #@products[:product_name] = product_price
#        if @products.keys.include?(product_name)
#          return false
#        else
#          return true
#        end
#     end
#   end
# end






#ap Orders.all
