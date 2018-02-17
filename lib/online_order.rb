require "csv"
require "awesome_print"

module Grocery
  class OnlineOrder < Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      super(id, products)
    end
  end
end
