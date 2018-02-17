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
      if status == :pending || status == :paid
        super(product_name, product_price)
      else
        raise ArgumentError.new("A new product can be added ONLY if the status is either pending or paid (no other statuses permitted).")
      end
    end

    def remove_product(product_name)
      if status == :pending || status == :paid
        super(product_name)
      elsif status == :processing
        raise ArgumentError.new("Order is already being processed, cannot be removed.")
      elsif status == :shipped
        raise ArgumentError.new("Order has already been shipped, cannot be removed.")
      else
        raise ArgumentError.new("Order has already been completed, cannot be removed.")
      end
    end
  end
end

  # Running initialization
  new_order = Grocery::OnlineOrder.new(101, {"Bananas"=>22.8, "Wholewheat flour"=>1.93}, 30, :processing)
  # ap new_order.id
  # ap new_order.products
  # ap new_order.customer_id
  # ap new_order.status

  # Running the total method
    # ap new_order.total

  # Running the add product method
    # ap new_order.add_product("apples", 2.99) >> true

  # Running the remove product method
    ap new_order.remove_product("Bananas")
    ap new_order
