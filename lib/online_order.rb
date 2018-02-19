require "csv"
require "awesome_print"
# require the order.rb file so we can access the super class
require_relative "order"
require_relative "customer"

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
      if @products != {}
        super + 10.00
      else
        super + 0.00
      end
    end

    def add_product(product_name, product_price)
      if status == :pending || status == :paid
        super
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

    def self.all
      all_online_orders = []
      CSV.read("support/online_orders.csv", "r").each do |order|
        id = order[0].to_i
        product_hash = {}
        order[1].split(";").each do |product|
          product_array = product.split(":")
          product_hash[product_array[0]] = product_array[1].to_f
        end
        customer_id = order[2].to_i
        status = order[3].to_sym
        all_online_orders << self.new(id, product_hash, customer_id, status)
      end
      all_online_orders
    end

    # Should return the customer id and order status in addition to products/prices
    def self.find(id)
      if id > self.all.length
        raise ArgumentError.new("id does not exist")
      else
        super
      end
    end

    def self.find_by_customer(chosen_id)
      customer_ids = []
      self.all.each do |online_orders|
        customer_ids << online_orders.customer_id.to_i
      end
      if customer_ids.include?(chosen_id)
        online_orders = []
        self.all.each do |order|
          if order.customer_id == chosen_id
            online_orders << order
          end
        end
        return online_orders
      else
        raise ArgumentError.new("id does not exist")
      end
    end
  end
end

# Running initialization
# new_order = Grocery::OnlineOrder.new(101, {"Bananas"=>22.8, "Wholewheat flour"=>1.93}, 30, :processing)
# ap new_order.id
# ap new_order.products
# ap new_order.customer_id
# ap new_order.status

# Running the total method
# ap new_order.total

# Running the add product method
# ap new_order.add_product("apples", 2.99) >> true

# Running the remove product method
# ap new_order.remove_product("Bananas")
# ap new_order

# Running self.all
# ap Grocery::OnlineOrder.all

# Running self.find
# ap Grocery::OnlineOrder.find(100)

# Running self.find_by_customer
# ap Grocery::OnlineOrder.find_by_customer(14)
