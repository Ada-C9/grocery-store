require 'pry'

require_relative 'order'
require 'awesome_print'

# The OnlineOrder class will inherit behavior from the Order class
# and include additional data to track the customer and order status.
# An instance of the Customer class will be used within each instance
# of the OnlineOrder class.

module Grocery

  class OnlineOrder < Order

    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def total
      # A total method which will calculate the total cost of the order by:
      # summing up the products
      # adding a 7.5% tax
      # ensure the result is rounded to two decimal places
      # add a $10 shipping for online order
      product_total = 0
      sub_total = 0
      @products.each_value do |prices|
        sub_total += prices
      end
      product_total = (sub_total * 0.075).round(2) + sub_total.round(2) + 10.00
      return product_total
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


  end #class OnlineOrder

end

products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
list_all_order = Grocery::OnlineOrder.new(1, products, 25, :complete)
ap list_all_order
# binding.pry
