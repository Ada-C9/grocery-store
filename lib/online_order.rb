require 'pry'
require 'csv'
require_relative './order.rb'
require_relative './customer.rb'

module Grocery

  class OnlineOrder < Grocery::Order
    attr_reader :order_id, :customer_id, :customer
    attr_accessor :fill_status, :prducts

    ONLINE_ORDERS = "support/online_orders.csv"

    def initialize(order_id, products, cust_id, fill_status)
      @order_id = order_id.to_i
      @products = products
      @customer_id = cust_id.to_i
      @fill_status = fill_status.to_sym
      @customer = Grocery::Customer.find(@customer_id)
    end

    def total
      unless super() == 0
        total = super() + 10.00
        total = total.round(2)
        return total
      else
        return total = 0.00
      end
    end

    def add_product(item, price)
      unless @fill_status == (:pending || :paid)
        return nil
      else
        super()
      end
    end

    def self.all
      all_online_orders = Array.new
      CSV.open(ONLINE_ORDERS, "r").each do |order|
        products_hash = {}
        products_split = order[1].split(';')
        products_split.each do |mash|
          split = mash.split(':')
          products_hash[split[0]] = split[1].to_f
        end
        new_order = self.new(order[0], products_hash, order[2], order[3])
        all_online_orders << new_order
      end
      return all_online_orders
    end
  end # onlineorder

end # grocery

binding.pry
