require 'csv'
require 'awesome_print'

require_relative 'order.rb'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :products, :customer_id, :customer, :status

    @@all_online_orders = []
# method to initialize an onlineorder using the inheritance
# from the order class
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
# inherited method from order class that adds 10 for shipping to the total
# if order is greater than 0
    def total
      if super == 0
        return 0
      else
        (super + 10).round(2)
      end
    end
# inherited method from order class that takes into account order status
    def add_product(product_name, product_price)
      if @status == :processing || @status == :shipped || @status == :complete
        raise ArgumentError
      elsif @status == :paid || @status == :pending
        return super
      end
    end
# completely overrides parent class' method
# to find all onlineorders from csv and handles customer_id and status
    def self.all
      @@all_online_orders = []
      CSV.read("support/online_orders.csv").each do |order|
        an_online_order = self.new(order[0].to_i, order[1], order[2].to_i, order[3])
        @@all_online_orders << an_online_order
      end
      @@all_online_orders
    end
# self.find inherited from parent class didn't need any changes
# and passes all the tests (or at least seems to)

# method to return an array of all orders from a single customers
# from the input of their customer id
    def self.find_by_customer(customer_id)
      Customer.find(customer_id)
      customers_orders = []
      self.all.each do |online_order|
        if online_order.customer_id == customer_id
          customers_orders << online_order
        end
      end
      return customers_orders
    end

  end
end
