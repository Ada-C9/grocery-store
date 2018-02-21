require 'csv'
require 'pry'

require_relative '../lib/order'
require_relative '../lib/customer'

# This program creates a new OnlineOrder. It also calculates the total of the
# order, adds products to the order, and removes products.
module Grocery
  class OnlineOrder < Order

    attr_reader :customer, :fulfillment_status

    @@all_online_orders = []

    def initialize(initial_id, initial_products, customer_id, status = :pending)
      super(initial_id, initial_products)
      @customer = get_known_customer_or_error(customer_id)
      @fulfillment_status = set_initial_fulfillment_status(status)
    end

    # Returns the total cost of the order, with the shipping cost if applicable.
    def total
      total_order_cost = super
      total_order_cost += 10.0 if total_order_cost > 0.0
      return total_order_cost
    end

    # Pre: Throws ArgumentError if fulfillment status is not pending or paid.
    #
    # Add provided product_name and product_cost as a new product if they create
    # a valid product. Returns 'true' if this was successful and 'false'
    # otherwise.
    def add_product(product_name, product_cost)
      check_if_can_add_products
      super(product_name, product_cost)
    end

    # Returns a list of all online orders.
    def self.all
      return Grocery::OnlineOrder.get_all
    end

    # Pre: throws ArgumentError if provided order_id is not an id for an order.
    #
    # Returns order with the id that matches provided order_id.
    def self.find(order_id)
      super(order_id) or raise ArgumentError.new("No online order with id.")
    end

    # Returns a list of all the orders for the provided customer_id.
    def self.find_by_customer(customer_id)
      return Grocery::OnlineOrder.find_orders_of_customer(customer_id)
    end

    private

    # Returns a list of all the orders for the provided customer_id. If the the
    # provided customer_id does not have any orders or if customer_id is not a
    # known costumer id, returns an empty list.
    def self.find_orders_of_customer(customer_id)
      orders_of_customer = []
      Grocery::OnlineOrder.get_all.each do |order|
        orders_of_customer << order.products if order.customer.id == customer_id
      end
      return orders_of_customer
    end

    # Returns a list of all online orders.
    def self.get_all
      Grocery::OnlineOrder.build_all if @@all_online_orders.empty?
      return @@all_online_orders
    end

    # Populates all_online_orders with all the online orders from a CSV.
    def self.build_all
      @@all_online_orders = [] # hard reset
      CSV.read('../support/online_orders.csv').each do |order_line|
        id = order_line[0].to_i
        products = build_products_hash(order_line[1])
        customer_id = order_line[2].to_i
        status = order_line[3].to_sym
        @@all_online_orders << Grocery::OnlineOrder.new(id, products,
          customer_id, status)
      end
    end

    # Order fulfillment status must be pending or paid. Otherwise throws
    # ArgumentError.
    def check_if_can_add_products
      if @fulfillment_status != :pending && @fulfillment_status != :paid
        raise ArgumentError.new("Only add products when order is pending or paid")
      end
    end

    # Pre: Throws ArgumentError is provided customer_id is not a customer id.
    #
    # Returns the customer with the same id number as provided requested_id.
    def get_known_customer_or_error(customer_id)
      order_customer = Grocery::Customer.find_customer_by_id(customer_id)
      raise ArgumentError.new("Customer ID not found") if order_customer.nil?
      return order_customer
    end

    # If provided status is one of the allowable fulfillment statuses, returns
    # provided status. Otherwise, returns ':pending'.
    def set_initial_fulfillment_status(status)
      return status if %i[pending paid processing shipped complete].any?(status)
      return :pending
    end

  end
end
