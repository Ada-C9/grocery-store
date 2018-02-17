require 'csv'
require 'awesome_print'
require_relative '../lib/order'
require_relative '../lib/customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :id, :products, :customer_id, :status

    def initialize(id, products, customer_id, status)
      super(id, products)
      @customer_id = customer_id
      @status = status
    end

    def self.all
      online_orders_entered = []
      CSV.read("../support/online_orders.csv").each do |row|
        id = row[0].to_i
        products = {}
        products_array = row[1].split(";")

        products_array.each do |item|
          name, price = item.split(':')
          products[name] = price.to_f
        end

        customer_id = row[2].to_i
        if row[3].nil?
          status = :pending
        else
          status = row[3].to_sym
        end
        online_orders_entered << OnlineOrder.new(id, products, customer_id, status)
      end
        return online_orders_entered
    end

  end

end
