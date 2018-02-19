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

    def self.all
      order_product = []
      result = {}
      all_order = []
      CSV.open(FILE_NAME, 'r').each do |product|
        order_product << "#{product[1]}"
        id = product[0].to_i
        order_product.each do |product_string|
          result = Hash[
            product_string.split(';').map do |pair|
              product, price = pair.split(':', 2)
              [product, price.to_i]
            end
          ]
        end
        all_order << Grocery::Order.new(id, result)
      end
      return all_order
    end


    def self.find(find_id)
      find_product = all
      return_value = nil
      find_product.each do |order|
        if find_id == order.id
          return_value = order
        end
      end
      return return_value
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

# ui to test wave 2 changes
# products = []
# CSV.open(FILE_NAME, 'r').each do |product|
#   puts "Order ##{product[0]} include: #{product[1]}"
#   products << Order.new(product[0])
# end
# first_order = Grocery::Order.all
# ap first_order
# puts first_order[4]
# order_id = first_order[0].split(", ")
# puts order_id[0]
# result = first_order[0].split(";")
# result = result.map{|x| x = x.split(":"); Hash[x.first.to_sym, x.last] }
# result = result.reduce(:merge)
# puts result


list_all_order = Grocery::Order.find(101)
ap list_all_order
# binding.pry












# Go! Luxi! Go!
