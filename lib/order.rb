require "csv"

# FILE_NAME = "../support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products_hash)
      @id = id
      @products_hash = products_hash

    end

    def total
      # TODO: implement total

      # sum the products
      sub_total = 0
      @products_hash.each do |product, price|
        sub_total += price
      end
      # return sub_total

      # add tax
      total = sub_total * 1.075

      # round to two decimal places
      total_round = total.round(2)

    end

    # add new product with price if not already present in list
    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products_hash.include?(product_name)
        return false
      else
        @products_hash[product_name] = product_price
        return true
      end
    end

    # remove product and price only if it already exists in list
    def remove_product(product_name)
      if !@products_hash.include?(product_name)
        return false
      else
        @products_hash.delete(product_name)
        return true
      end
    end

    # returns appropriate information from all orders csv file
    def self.all
      orders_array = []
      CSV.open("support/orders.csv", "r").each do |order|
        id = [0]
        products_hash = {}

        products_array = order[1].split(";")
        products_array.each do |product|
          product_info = product.split(":")
          products_hash[product_info[0]] = product_info[1].to_f
        end

        orders_array << Order.new(id, products_hash)
      end
      return orders_array
    end

    # finds order using id field and returns that Order instance
    def self.find(order_id)
      orders_array = self.all
      order_found = ""
      orders_array.each do |order|
        if order.id == order_id
          order_found = order
        else
          return "That order does not exist."
        end
      end
      return order_found
    end

  end # class Order

end # module Grocery

#
# # test that Order class can take data in the format found in csv file
# first_order_info = nil
# CSV.open("../support/orders.csv", "r") do |file|
#   first_line = file.readline
#   first_order_info = first_line
# end
#
# puts "#{first_order_info}"
# puts first_order_info.class
# #
# first_order = Grocery::Order.new(first_order_info)
#
# puts "#{first_order.id}"
# puts "#{first_order.products}"
# puts "#{first_order.total}"

# testing .all class method
# puts "#{Grocery::Order.all}"




















#
