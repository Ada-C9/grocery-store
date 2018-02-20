# online order
require 'awesome_print'
require 'csv'
require_relative "order.rb"

#example

module Grocery

  class OnlineOrder < Order

    attr_reader :id, :products :customer_id :status

    def initialize(id, products, customer_id, fulfillment_status)
      @id = id
      @products = products
      @customer_id = customer_id
      @fulfillment_status = status.to_sym

      # tip from Katie: 16 and 22 are the customer id's that exsit but do not have orders


    end

    def self.all
      array_of_orders = []
      CSV.open("support/online_orders.csv", 'r').each do |line|

        product_list = line[1].split(';')
        product_hash = {}
        product_list.each do |item|
          product = item.split(':')
          product_hash[product[0]] = product[1]
        end
        array_of_orders << Grocery::OnlineOrder.new(line[0].to_i, product_hash, customer_id, fulfillment_status)
      end
      array_of_orders
    end

    # (shouldn't need to rewrite out a new self.find method since it inherits from Order class and should work the same.)

    def self.find_by_customer(customer_id)
      all_orders = Grocery::OnlineOrder.all

      all_orders.each do |single_order|
        order_list = []
        if single_order[2] == customer_id
          order_list << single_order
        end
        return order_list
      end
    end

    def total
      shipping_fee = 10.0
      return super + shipping_fee
    end

    def add_product(product_name, product_price)
      if @status == :pending || @status == :paid
        return false if @products.has_key?(product_name)
        @products[product_name] = product_price
        return true
      else
        raise ArgumentError.new("Status is neither pending nor paid")
      end
    end

  end # end of OnlineOrder Class




end # end of Module Class
