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

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        super
      else
        raise ArgumentError.new("A new product to be added ONLY if the status is either pending or paid")
      end
    end

  end # class OnlineOrder

end # module Grocery

# ui for initialize method
products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
# products = {}
test_online_order = Grocery::OnlineOrder.new(1, products, 25, :paid)
ap test_online_order
ap test_online_order.customer_id
ap test_online_order.products
ap test_online_order.add_product("takoyaki", 5.00)
ap test_online_order

# two customer id's with no product 16 and 22
# binding.pry
