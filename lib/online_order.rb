require 'csv'
require_relative '../lib/order'

module Grocery

  class OnlineOrder < Order

    attr_reader :id, :products, :status, :customer_obj, :total, :add_product, :find_by_customer

    def initialize (id, products, customer_obj, status)
      fufillment_status = [:pending, :paid, :processing, :shipped, :complete]
      @id = id.to_i
      @products = products
      @status = status.to_sym
      until fufillment_status.include?(@status)
        @status = pending.to_sym
      end
      @customer_obj = customer_obj.to_i
    end

    def self.all
      all_online_orders = []
      if all_online_orders.empty?
        file = CSV.open("support/online_orders.csv", "r")
        file.each do |line|
          id = line[0]
          items_string = line[1]
          customer_id = line[2]
          status = line[3].to_sym

          products = {} #will take k/v pairs delimited by colon

          semicolon_split = items_string.split(';')

          semicolon_split.each do |string|
            key_value_split = string.split(':')
            products[key_value_split[0]] = key_value_split[1].to_f
          end
          all_online_orders << OnlineOrder.new(id,products, customer_id, status)
        end
        return all_online_orders
      else
        return all_online_orders
      end
    end

    def self.find(id)
      all_orders = Grocery::OnlineOrder.all
      all_orders.each do |order|
        if order.id == id
          return order
        end
      end
      return "ERROR: Order not found"
    end

    def self.find_by_customer(customer_id)
      customer_orders = []
      all_orders = Grocery::OnlineOrder.all
      all_orders.each do |order|
        if order.customer_id == customer_id
          customer_orders << order
        end
      end
      return customer_orders
    end

    def total
      if products == {}
        return super()
      else
        return super() + 10
      end
    end
    # The add_product method should be updated to permit a new product to be added
    # ONLY if the status is either pending or paid (no other statuses permitted)
    def add_product(product_name, product_price)
      unless [:pending, :paid].include?(status)
        return nil
      else
        @products[product_name] = product_price
      end
    end
  end
end
# all_online_orders = Grocery::OnlineOrder.all
# online_order = Grocery::OnlineOrder.new(1,{"Lobster" => 17.18, "Annatto seed" => 58.38, "Camomile" => 83.21},37, :complete)
# online_order.add_product("Soy Sauce", 5.00)
# puts all_online_orders.find(17)
