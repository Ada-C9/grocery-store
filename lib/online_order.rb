require 'csv'
require 'awesome_print'
require 'pry'


module Grocery

  class OnlineOrder < Order
    attr_accessor :order_status, :customer
    def initialize(id, products, customer, order_status = "pending")
      super(id, products)
      @customer = customer
      @order_status = order_status
    end

    def total()
      if super() > 0
        return super() + 10
      else
        return super()
      end
    end

    def add_product()
      if @order_status = "pending" || @order_status = "paid"
        return super()
      else
        return nil
      end#end if statement
    end

    def self.all
    end
  end#end class OnlineOrder
end#end Grocery module
