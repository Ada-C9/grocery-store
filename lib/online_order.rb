require 'pry'

require_relative 'order'
require 'awesome_print'
require 'csv'

FILE_NAME = 'support/online_orders.csv'

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

    def self.all
      order_product = []
      result = {}
      all_online_order = []
      CSV.open(FILE_NAME, 'r').each do |product|
        order_product << "#{product[1]}"
        id = product[0].to_i
        customer_id = product[2].to_i
        status = product[3].to_sym
        order_product.each do |product_string|
          result = Hash[
            product_string.split(';').map do |pair|
              product, price = pair.split(':', 2)
              [product, price.to_i]
            end
          ]
        end
        all_online_order << Grocery::OnlineOrder.new(id,result, customer_id, status)
      end
      return all_online_order
    end

    def self.find(find_id)
      super
    end

    # def self.find_by_customer(customer_id)
    #   find_product = self.all
    #   return_value = nil
    #   find_product.each do |order|
    #     if find_id == order.id
    #       return_value = order
    #     end
    #   end
    #   return return_value
    # end

  end # class OnlineOrder

end # module Grocery

# # ui for initialize, total, and add_product
# products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
# # products = {}
# test_online_order = Grocery::OnlineOrder.new(1, products, 25, :complete)
# ap test_online_order
# ap test_online_order.customer_id
# ap test_online_order.products
# ap test_online_order.add_product("takoyaki", 5.00)
# ap test_online_order

# # ui for self.all method
# online_order = Grocery::OnlineOrder.all
# ap online_order

# ui for self.find() method
online_order = Grocery::OnlineOrder.find(5)
ap online_order

# two customer id's with no product 16 and 22
# binding.pry
