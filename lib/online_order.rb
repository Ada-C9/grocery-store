require "csv"
require "awesome_print"
# require the order.rb file so we can access the super class
require_relative "order"

# FILE_NAME = "../support/online_orders.csv"

module Grocery
  # Order is a super class and OnlineOrder will inherit behavior from it
  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def total
      unless @products.count <= 0
        super + 10.00
      end
    end

  end

end


# Running total method
  # new_order = Grocery::OnlineOrder.new(101, {"Bananas": 22.8, "Wholewheat flour": 1.93}, 30, :pending)
  # ap new_order.id
  # ap new_order.products
  # ap new_order.customer_id
  # ap new_order.status
