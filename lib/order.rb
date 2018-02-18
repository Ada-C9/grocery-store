require 'csv'
require 'awesome_print'

FILENAME = "support/orders.csv"



module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0.0
      @products.each do |product, price|
        sum += price * 1.075
      end
      sum = sum.round(2)
      return sum
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        return true
        @products[:product_name] = product_price
        before_count = @products.count
        if @products.count == before_count + 1
          return true
        else
          return false
        end
      end
    end


    def self.all
      # data is an array of arrays
      data = CSV.read(FILENAME)
      # data and put into order format
      orders = []
      data.each do |line|
        id = line[0]
        products_strings = line[1].split(";")
        products = {}
        product_data = products_strings[0].split(":")
        product_name = product_data[0]
        product_price = product_data[1]
        products[product_name] = product_price
        #last line
        orders << Order.new(id, products)
        puts products
        puts orders
      end
      return orders
    end
    # def self.find(id)
    # end

  end
end

Grocery::Order.all

# display a the first product
# CSV.open(FILENAME,'r') do |file|
#   first_line = file.readline
#   puts "first line was #{first_line}"
#   data.each do |id, raw_products|
#     puts "Product: #{id}: #{raw_products}"
#   end
# end
