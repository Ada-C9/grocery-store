require 'csv'
require 'awesome_print'

require_relative 'order.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :products, :customer_id, :customer, :status

    @@all_online_orders = []

    def initialize id, products, customer_id, status = :pending
      super(id, products)
      @customer_id = customer_id
      @customer = Customer.find(@customer_id)
      if status.class == Symbol
        @status = status
      elsif status.class == String
        @status = status.to_sym
      end
    end

    def total
      if super == 0
        return 0
      else
        (super + 10).round(2)
      end
    end

    def add_product(product_name, product_price)
      if @status == :processing || @status == :shipped || @status == :complete
        return nil
      elsif @status == :paid || @status == :pending
        return super
      end
    end

    def self.all
      @@all_online_orders = []
      CSV.read("support/online_orders.csv").each do |order|
        an_online_order = self.new(order[0].to_i, order[1], order[2].to_i, order[3])
        @@all_online_orders << an_online_order
      end
      @@all_online_orders
    end

  end
end
#
