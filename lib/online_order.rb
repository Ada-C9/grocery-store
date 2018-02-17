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
        super + 10
      end
    end

    def add_product(product_name, product_price)
      if status == "pending" || status == "paid"
        super(product_name, product_price)
      else
        raise ArgumentError.new("A new product can be added ONLY if the status is either pending or paid (no other statuses permitted).")
      end

    end

  end


  # Running initialization
  new_order = Grocery::OnlineOrder.new(101, {"Bananas": 22.8, "Wholewheat flour": 1.93}, 30, :pending)
  # ap new_order.id
  # ap new_order.products
  # ap new_order.customer_id
  # ap new_order.status

  # Running the total method
    # ap new_order.total

  # 
