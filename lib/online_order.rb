require "csv"
require "ap"
require_relative "order.rb"
require_relative "customer.rb"

module Grocery
  class OnlineOrder < Order
    attr_accessor :customer, :online_order_id, :products, :fulfillment_status

      @customer = Customer.find(id)
      @products = products
      @online_order_id = online_order_id
      @fulfillment_status = fulfillment_status

    end

    def self.all
      online_orders_array = CSV.read("support/online_orders.csv", "r")
      online_orders = []

      online_orders_array.each do |order|
        order_id = order[0].to_i
        products_hash = {}
        id = order[2].to_i
        status = order[3].to_sym

        order[1].split(";").each do |product|
          product.split(":")[0]
          products_hash[product.split(":")[0]] = product.split(":")[1].to_f
        end
        online_orders << OnlineOrder.new(order_id, products_hash, id, status)
      end
      online_orders
    end

    def total
      if products != {}
        super + 10
      else
        super
      end
    end

    def add_product(product, price)
      if @fulfillment_status == (:pending || :paid )
        super
      else
        case @fulfillment_status
        when :processing
          raise ArgumentError.new("Your order is processing, you will have to make another order or call costumer services.")
        when :shipped
          raise ArgumentError.new("Too late to update, your order is on the way!")
        when :complete
          raise ArgumentError.new("This order is completed, should be at the delivery address, if you have not recieved it yet, please call costumer service.")
        end
      end
    end

    def self.find(id_number)
      orderlist =  self.all
      the_order = nil
      orderlist.each do |order|
        if order.online_order_id == id_number
          the_order = order
        end
      end
      if the_order == nil
        raise ArgumentError.new("That order does not exist.")
      else
        return the_order
      end
    end

    def self.find_by_customer(id)
      the_customer = Customer.find(id)
      if the_customer == nil
        raise ArgumentError.new("The customer does not exist.")
      else
        orderlist = self.all
        the_customer_orders = []
        orderlist.each do |order|
          if order.id == id
            the_customer_orders << order
          end
        end
      end
      return the_customer_orders
    end
  end
end
