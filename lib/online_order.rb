require 'csv'
require 'awesome_print'

module Grocery
  class OnlineOrder < Order

    attr_reader: :id, :products, :customer_id, :status

    @@all_online_orders = []

    def initialize(order_id, products, customer_id, :status)

      super(total, add_product)

      @order_id = order_id
      @products = products
      @customer_id = customer_id
      @fulfillment_status = :status

      if :status == nil
        :status == "pending"
      end
    end

    def total
      return super + 10
    end

    def add_product(product_id, product_name)
      if !(:status = "pending" || :status == "paid")
        return super
      else
        return ArgumentError
      end
    end

    def self.all
      CSV.foreach("../support/online_orders.csv") do |row|
        row[1] = row[1].split(";")

        products_hash = {}

        row[1].map! do |products|
          products = products.split(":")
          products_hash[products[0]] = products[1].to_f
        end
        @@all_online_orders << [row[0].to_i, products_hash, row[2].to_i, row[3]]

        return @@all_online_orders

      end
    end

    def self.find(customer_id)
      if customer_id >= @@all_online_orders
        customer_id

    end

  end
end
