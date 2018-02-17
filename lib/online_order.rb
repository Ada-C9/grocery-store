require 'csv'
require 'awesome_print'
require_relative 'order.rb'
require_relative 'customer.rb'

ONLINE_FILE_NAME = 'support/online_order.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      # @id = id
      # @products = products
      @customer_object = customer_id
      @status = status.to_sym
    end


    def total
      old_total = super()
      new_total = old_total + 10
      return new_total.round(2)
    end

  end
end

new_online_order = Grocery::OnlineOrder.new(434, {"product": 5.50, "apples": 4.50},45,"pending")

puts new_online_order.total

puts new_online_order.products

puts Grocery::Customer.find(new_online_order.customer_id)
