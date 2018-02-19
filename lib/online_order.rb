require 'csv'
require 'awesome_print'
require_relative '../lib/order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :id, :customer_id, :status
    attr_accessor :products

    def initialize(id, products, customer_id, status)
      @id = id
      @products = products
      @customer_id = customer_id
      @status = status
    end
  end
end
