require 'csv'
require 'awesome_print'
require_relative 'order.rb'

ONLINE_FILE_NAME = 'support/online_order.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :customer_object, :fulfillment_status

    def initialize(id, products, customer_object, fulfillment_status)
      super(id, products)
      # @id = id
      # @products = products
      @customer_object = customer_object
      @fulfillment_status = :fulfillment_status
    end


    def total
      old_total = super()
      new_total = old_total + 10
      return new_total
    end

  end
end

new_online_order = Grocery::OnlineOrder.new(434, {"product": 5.50, "apples": 4.50},45,"pending")

puts new_online_order.total

puts new_online_order.products
