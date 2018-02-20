require 'csv'
# require 'faker'

require_relative '../lib/order'
require_relative '../lib/customer'
# require_relative './order'
# require_relative './customer'



module Grocery
  class OnlineOrder < Order

    attr_reader :customer, :fulfillment_status

    @@all_online_orders = []

    def initialize(initial_id, initial_products, initial_customer_id,
      initial_fulfillment = :pending)
      super(initial_id, initial_products)
      @customer = get_customer(initial_customer_id)
      @fulfillment_status = set_initial_fulfillment_status(initial_fulfillment)
    end

    def total
      total_order_cost = super
      return total_order_cost > 0.0 ? total_order_cost + 10.0 : total_order_cost
    end


    def add_product(product_name, product_cost)
      check_if_can_add_products # fulfillment_status must be pending or paid
      super(product_name, product_cost) #TODO: no need for return??
    end

    #
    def self.all

    end

    #
    def self.find(requested_id)
      super(requested_id) or raise ArgumentError.new("No online order with id .")
      # order_with_requested_id = super(requested_id)
      # # order_with_requested_id = all.find { |order| order.id == requested_id }
      # if order_with_requested_id.nil?
      #   raise ArgumentError.new("No online order with id #{requested_id.inspect}.")
      # end
      # return order_with_requested_id
    end

    #
    def self.find_by_customer(requested_customer_id)
      return if Grocery::OnlineOrder.find(requested_customer_id).nil?
      orders_of_customer = []
      # return all.select { |order| order.products if order.customer.id == requested_customer_id }
      # end

      all.each do |order|
        orders_of_customer << order.products if order.customer.id == requested_customer_id
      end
      return orders_of_customer
    end

    private

    def get_all
      build_all if @@all_online_orders.empty?
      return @@all_online_orders
    end


    def build_all
      CSV.read("../support/online_orders.csv").each do |order_line|
        @@all_online_orders << Grocery::OnlineOrder.new(
          order_line[0].to_i, #id
          build_products_hash(order_line[0]), # from parent
          order_line[2].to_i,  # customer_id
          order_line[3].to_sym, # order_status
          false) # not new
      end
    end

    # def build_all
    #   CSV.read("../support/online_orders.csv").each do |order_line|
    #     order_id = order_line[0].to_i
    #     product_hash = build_products_hash(order_line[0])
    #     customer_id = order_line[2].to_i
    #     order_status = order_line[3].to_sym
    #     @@all_online_orders << Grocery::OnlineOrder.new(order_id, product_hash,
    #         customer_id, order_status)
    #   end
    # end


    # Order fulfillment status must be pending or paid. Otherwise throws
    # ArgumentError.
    def check_if_can_add_products
      if @fulfillment_status != :pending && @fulfillment_status != :paid
        raise ArgumentError.new("Only add products when order is pending or paid.")
      end
    end

    #
    def get_customer(customer_id)
      order_customer = Grocery::Customer.find(customer_id)
      if order_customer.nil? # creates a new fake customer if can't find id
        order_customer = Grocery::Customer.new(customer_id, Faker::Internet.email,
        {street: Faker::Address.street_address, city:Faker::Address.city,
          state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code})
      end
      return order_customer
    end

    def set_initial_fulfillment_status(possible_status)
      @fulfillment_status =
      is_valid_fulfillment_status?(possible_status) ? possible_status : :pending
    end


    def is_valid_fulfillment_status?(possible_status)
      return possible_status.class == Symbol && %i[pending paid processing
        shipped complete].any?(possible_status)
    end

  end

end
