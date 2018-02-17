require "csv"
require "awesome_print"
# require the order.rb file so we can access the super class
require_relative "order"

FILE_NAME = "../support/online_orders.csv"

module Grocery
  # Order is a super class and OnlineOrder will inherit behavior from it
  class OnlineOrder < Order
    attr_reader :customer, :fullfillment_status

    def initialize(customer, fullfillment_status)
      @customer = customer
      @fullfillment_status = fullfillment_status
    end

  end

end
end
