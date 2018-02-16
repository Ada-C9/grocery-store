require 'pry'

require 'csv'
require 'awesome_print'

FILE_NAME = 'support/orders.csv'

module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    def total
      # A total method which will calculate the total cost of the order by:
      # summing up the products
      # adding a 7.5% tax
      # ensure the result is rounded to two decimal places
      product_total = 0
      sub_total = 0
      @products.each_value do |prices|
        sub_total += prices
      end
      return product_total = (sub_total * 0.075).round(2) + sub_total.round(2)
    end


    def add_product(product_name, product_price)
      # An add_product method which will take in two parameters,
      # product name and price, and add the data to the product collection
      # It should return true if the item was successfully added and false
      # if it was not
      return false if @products.has_key?(product_name)
      # else
      @products[product_name] = product_price
      #
      # puts "products is #{@products}"
      return true
      # end
    end

    # def to_s
    #   return "#{@id}: #{@product}"
    # end

    def self.all
      my_orders = []
      CSV.open(FILE_NAME, 'r').each do |product|
        my_orders << "#{product[1]}"
      end
      # my_orders.each do |index|
      #   result = index.split("; ")
      #   result = result.map{|x| x = x.split(": "); Hash[x.first.to_sym, x.last] }
      #   result = result.reduce(:merge)
      # end
      return my_orders
    end


    def self.find(id)
    end

  end # class Order

end # module Grocery

# # ui to test wave 1 changes
# products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
# order = Grocery::Order.new(1337, products)
# puts order.products
# order.add_product("cracker", 5.00)
# puts order.products
# puts order.total

# ui to test wave 2
# products = []
# CSV.open(FILE_NAME, 'r').each do |product|
#   puts "Order ##{product[0]} include: #{product[1]}"
#   products << Order.new(product[0])
# end
#
first_order = Grocery::Order.all
puts first_order
puts first_order.class
puts first_order[0]
result = first_order[0].split(";")
result = result.map{|x| x = x.split(":"); Hash[x.first.to_sym, x.last] }
result = result.reduce(:merge)
puts result
puts result[]
# binding.pry












# Go! Luxi! Go!
