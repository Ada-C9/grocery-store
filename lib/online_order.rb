require 'csv'
require 'awesome_print'
require_relative 'order.rb'

ONLINE_FILE_NAME = 'support/online_order.csv'


module  Grocery

  class OnlineOrder < Order
    attr_reader :id, :products, :customer_object, :fulfillment_status

    def initialize(customer_object, fulfillment_status)
      super()
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

new_online_order = Grocery::OnlineOrder.new(434, {"product": 5.50, "apples": 4.50},Grocery::Customer.new(4,"karinna@gmail.com","227 Boylston"),pending)

puts new_online_order.total
