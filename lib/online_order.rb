require 'csv'
require 'awesome_print'
require_relative '../lib/order'

module Grocery
  class OnlineOrder < Grocery::Order
    attr_reader :id, :products, :customer_id, :status, :total

    FILE_NAME = "support/online_orders.csv"

    @@online_orders = []

    def initialize(id, products, customer_id, status = :pending)
      #need super
      @id = id.to_i
      @products = products
      @customer_id = customer_id
      @status = status
    end

    def self.all
      if @@online_orders.empty?
        CSV.open(FILE_NAME, 'r') do |file|
          file.each do |line_item|

            id = line_item[0]
            items_string = line_item[1]
            customer_id = line_item[2]
            status = line_item[3].to_sym

            products = {} #will take k/v pairs delimited by colon

            semicolon_split = items_string.split(';')

            semicolon_split.each do |string|
              key_value_split = string.split(':')
              products[key_value_split[0]] = key_value_split[1]
            end
            @@online_orders << OnlineOrder.new(id,products, customer_id, status)
          end
          return @@online_orders
        end
      else
        return @@online_orders
      end
    end

    def total
      if products == {}
        return super()
      else
        return super() + 10
      end
    end

    def add_product(product_name, product_price)
      if status == :processing || :shipped || :complete
        return nil
      else
        super()
      end

    end


  end
end
