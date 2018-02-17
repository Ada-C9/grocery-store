require 'csv'

FILE_NAME = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.sum
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end


    def add_product(product_name, product_price)

      return false if @products.has_key?(product_name)
      @products[product_name] = product_price
      p @products
      # else
      return true
    end

    def remove_product(product_name)
      p @products
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end



    def self.all

      # | Field    | Type     | Description
      # |----------|----------|------------
      # | ID       | Integer  | A unique identifier for that Order
      # | Products  | String  | The list of products in the following format: `name:price;nextname:nextprice`

      all_orders = []

      CSV.open(FILE_NAME, 'r').each do |order|
        # ..support/orders.csv < -- wont work inrake
        transaction_id_products = []
        id = order[0]
        products_to_purchase = {}

        transaction_id_products << id

        order[1].split(";").each do |item|
          products = item.split(":")
          products_to_purchase[products[0]] = products[1]

        end
        transaction_id_products << products_to_purchase
        # p purchase_id_products
        all_orders << transaction_id_products
      end
      return all_orders
      # returns a collection of `Order` instances, representing all of the Orders described in the CSV
    end


    #
    # id = ?
    # products = ?
    # all_orders << Order.new(id, products)
    # all_orders <- how to populate it with the CSV data
    # every element in the array is an Order instance

    #
    #     def self.find(id)
    #       # takes one parameter (an id)
    #       # returns one order from the CSV
    #       # returns an instance of `Order` where the value of the id field in the CSV w/ the given id
    #       # matches the passed parameter
    #       # all_orders = Order.all
    #
    #       # Error handling, what if it calls for an ID that DNE/nil?
    #     end
    #
  end
end
#
# class Customer
# # Order 'has a' Customer
#   def initialize (id, email, address)
#     @id = id
#     @email = email
#     @address = address
#   end
#
#   def self.all
#     # returns a collection of `Customer` instances, representing all of the Customer described in the CSV.
#
#   end
#
#   def self.find(id)
#     # returns an instance of `Customer` where the value of the id field in the CSV matches the passed parameter
#   end
#
# end
# #
# class Order < OnlineOrder
#   # woah woah woah, lets revisit this section later
#
#   # going to use inheritance class
#
#   # An **instance** of the `Customer` class will be used _within_ each **instance** of the `OnlineOrder` class.
#
#
# end
