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

    def total()
      if super() > 0
        return super() + 10
      else
        return super()
      end
    end

    def add_product(product_name, product_price)

      if @order_status == :pending || @order_status == :paid
        return super(product_name, product_price)
      else
        return nil
      end#end if statement
    end

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

    def self.find()
    end
  end#end class OnlineOrder
end#end Grocery module

  # ap Grocery::OnlineOrder.all
