require 'csv'
require 'faker'
require 'pry'
require 'awesome_print'


require_relative '../lib/order'
require_relative '../lib/customer'
# require_relative './order'
# require_relative './customer'



module Grocery
  class OnlineOrder < Order

    attr_reader :customer, :fulfillment_status

    @@all_online_orders = []

    def initialize(initial_id, initial_products, initial_customer_id,
      initial_fulfillment = :pending, is_from_csv = false)
      super(initial_id, initial_products, is_from_csv)
      @customer = get_customer(initial_customer_id)
      @fulfillment_status = set_initial_fulfillment_status(initial_fulfillment)
    end

    def total
      total_order_cost = super
      return total_order_cost > 0.0 ? total_order_cost + 10.0 : total_order_cost
    end


    def add_product(product_name, product_cost)
      check_if_can_add_products # fulfillment_status must be pending or paid
      return super(product_name, product_cost) #TODO: no need for return??
    end

    #
    def self.all
      return Grocery::OnlineOrder.get_all
    end

    #
    def self.find(requested_id)
      # found_order = Grocery::OnlineOrder.get_all.find { |order| order.id == requested_id }
      # if found_order.nil?
      #   raise ArgumentError.new("No online order with id .")
      # end
      # return found_order
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

      Grocery::OnlineOrder.get_all.each do |order|
        orders_of_customer << order.products if order.customer.id == requested_customer_id
      end
      return orders_of_customer
    end

    private

    def self.get_all
      Grocery::OnlineOrder.build_all if @@all_online_orders.empty?
      return @@all_online_orders
    end


    def self.build_all
      CSV.read("../support/online_orders.csv").each do |order_line|
        @@all_online_orders << Grocery::OnlineOrder.new(
          order_line[0].to_i, #id
          build_products_hash(order_line[1]), # from parent
          order_line[2].to_i,  # customer_id
          order_line[3].to_sym, # order_status
          true) # not new
      end
    end

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
          state: Faker::Address.state_abbr, zip: Faker::Address.zip_code})
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

# ap Grocery::OnlineOrder.find(61)
