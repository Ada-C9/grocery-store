require "csv"
require "awesome_print"

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :customer, :status
    attr_accessor :products

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status.to_sym
    end
  end
end
