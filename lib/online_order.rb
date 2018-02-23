require 'csv'
require 'awesome_print'
require 'pry'
require_relative './order'

ONLINE_ORDER_FILE_NAME = 'support/online_orders.csv'

module Grocery

  class OnlineOrder < Order
    attr_accessor :order_status, :customer_id
    def initialize(id, products, customer_id, order_status = :pending)
      super(id, products)
      @customer_id = customer_id
      @order_status = order_status
    end

    #should be the same, except it will add a $10 shipping fee
    def total()
      if super() > 0
        return super() + 10
      else
        return super()
      end
    end

    #method should be updated to permit a new product to be added ONLY if
    # the status is either pending or paid (no other statuses permitted)
    def add_product(product_name, product_price)

      if @order_status == :pending || @order_status == :paid
        return super(product_name, product_price)
      else
        return nil
      end#end if statement
    end

    #returns a collection of OnlineOrder instances, representing all of the
    #  OnlineOrders described in the CSV.
    def self.all()
      orders = []
      #opening CSV
      CSV.read(ONLINE_ORDER_FILE_NAME, 'r').each do |order|
        id = order[0].to_i
        customer_id = order[2].to_i
        @order_status = order[3].to_sym

        step1 = order[1].split(";")
        step2 = []
        step1.each do |pair|
          step2 << pair.split(":")
        end

        products = step2.to_h
        orders << Grocery::OnlineOrder.new(id,products,customer_id,@order_status)
      end#reads and parses through CSV file

      return orders #array of instances of Order
    end

    # self.find_by_customer(customer_id) - returns a list of OnlineOrder
    # instances where the value of the customer's ID matches the passed
    # parameter.
    def self.find_by_customer(cust_id)
      order_list = Grocery::OnlineOrder.all
      cust_array = []
      order_list.each do |order|
        if order.customer_id == cust_id
          cust_array << order
        end#end if
      end#end order_list loop

      return nil if cust_array == []
      return cust_array
    end#end find_by_customer method
  end#end class OnlineOrder
end#end Grocery module
