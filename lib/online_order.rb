require_relative './order.rb'
require_relative './customer.rb'

module Grocery

  class OnlineOrder < Grocery::Order
    attr_reader :order_id, :customer_id, :customer
    attr_accessor :fill_status, :prducts

    def initialize(order_id, products, cust_id, fill_status)
      @order_id = order_id.to_i
      @products = products
      @customer_id = cust_id
      @fill_status = fill_status.to_sym
      @customer = Grocery::Customer.find(@customer_id)
    end

    def total
      total = super() + 10.00
      total = total.round(2)
      return total
    end

  end # onlineorder

end # grocery
