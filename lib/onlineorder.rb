require 'csv'
require 'awesome_print'
require_relative '../lib/order'
require_relative '../lib/customer'

module Grocery
  class OnlineOrder < Order
    attr_reader  :status, :customer

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status
    end
    def total
      return super + 10
    end
    def add_product
      if status == pending || status == paid
        super(product_name,product_price)
      else
        raise ArgumentError.new
      end
    end
    def self.all
      all_orders = []
      CSV.open('../support/online_orders.csv', 'r').each do |order|
        product_hash = {}
        id = order[0].to_i
        order[1].split(";").each do |pair|
          new_pair = pair.split(":")
          key = new_pair[0]
          value = new_pair[1].to_f
          product_hash[key] = value

        end
        customer = Grocery::Customer.find(order[2].to_i)
        status = order[3].to_sym
        all_orders << Grocery::OnlineOrder.new(id, product_hash, customer, status)

      end
      return all_orders
    end
    def self.find(id)
      return super(id)
    end
    def self.find_by_customer(customer_id)
      self.all.each do |online_order|
        customers_online_orders = []

        if online_order.id == customer_id
          customers_online_orders<<online_order
          return customers_online_orders
        end
      end#if order.id == nil
      raise  ArgumentError.new("order id #{id} does not exists")

    end
  end
end
Grocery::OnlineOrder.all
ap Grocery::OnlineOrder.find(1)
ap Grocery::OnlineOrder.find_by_customer(1)
