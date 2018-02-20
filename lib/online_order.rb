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
      # if @status == NilClass
      #   return @status = :pending
      # end
    end

    def total
      if super == 0
        return nil
      else
        final_total = super + 10
      end
      return final_total
    end

    # def add_product(product_name, product_price)
    #   # An add_product method which will take in two parameters,
    #   # product name and price, and add the data to the product collection
    #   # It should return true if the item was successfully added and false
    #   # if it was not
    #   return false if @products.has_key?(product_name)
    #   # else
    #   @products[product_name] = product_price
    #   #
    #   # puts "products is #{@products}"
    #   return true
    #   # end
    # end

  end # class OnlineOrder

end # module Grocery

# ui for initialize method
# products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
products = {}
test_online_order = Grocery::OnlineOrder.new(1, products, 25, :complete )
ap test_online_order
ap test_online_order.customer_id
ap test_online_order.products
ap test_online_order.total
ap test_online_order.status

# two customer id's with no product 16 and 22
# binding.pry
