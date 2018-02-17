require 'csv'
require 'awesome_print'

require_relative 'order.rb'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer, :status

    def initialize id, products, customer_id, status = :pending
      super(id, products)
      @customer = Customer.find(customer_id)
      @status = status
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

  end
end
#
