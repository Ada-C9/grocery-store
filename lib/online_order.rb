require 'csv'
require 'awesome_print'
require_relative '../lib/order'

module Grocery
  class OnlineOrder < Order

    attr_reader :id, :products, :customer_id, :status

    @@all_online_orders = []

    def initialize(id, products, customer_id, status)
      super(id, products)
      @id = id
      @products = products
      @customer_id = customer_id
      @status = status

      if @status == nil
        @status == "pending"
      end
    end

    def total
      if super == 0
        return 0
      else
        return super + 10
      end
    end

    def add_product(product_name, product_price)
      if @status == "pending" || @status == "paid"
        return super
      else
        return ArgumentError
      end
    end

    def self.all
      @@all_online_orders = []
      CSV.foreach("support/online_orders.csv") do |row|
        row[1] = row[1].split(";")
        products_hash = {}

        row[1].map! do |products|
          products = products.split(":")
          products_hash[products[0]] = products[1].to_f
        end

        @@all_online_orders << [row[0].to_i, products_hash, row[2].to_i, row[3]]
      end
      return @@all_online_orders
    end

    def self.find(id)
      if id <= self.all.length
        specific_online_order = self.all[id - 1]
        return specific_online_order
      else
        raise ArgumentError
      end
    end

    def self.find_by_customer(customer_id)
      @customer_orders = []
      self.all.each do |i|
        if customer_id == i[2]
          @customer_orders << i
          return @customer_orders
        else
          raise ArgumentError
        end
      end
    end

  end
end
