#Lily Sky Grocery Store - Online Order
#Ada C9

require 'awesome_print'
require 'csv'
require_relative 'order'
require_relative 'customer'

module Grocery
  class OnlineOrder < Order
    attr_reader :customer, :status

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status
    end

    def total
      if super() > 0
        return super() +10
      else return 0
      end
    end

    def add_product(product_name, product_price)
      if [:processing, :shipped, :complete].include?(@status)
        return false
      else
        return super(product_name, product_price)
      end
    end

    def self.all
      orders = []
      CSV.read("support/online_orders.csv").each do |line|
        sorted_list = line[1].split(";")
        sorted_list_2 = []

        sorted_list.each do |pair|
          sorted_list_2 << pair.split(":")
        end

        products = sorted_list_2.to_h
        orders << Grocery::OnlineOrder.new(line[0], products, line[2], line[3].to_sym)
      end
      return orders
    end

    def self.find(id)
      OnlineOrder.all.each do |item|
        if item.id == id
          return item
        end
      end
      return nil
    end

    def self.find_by_customer(customer)
      all_orders = []
      OnlineOrder.all.each do |item|
        if item.customer == customer
          all_orders << item
        end
      end
      return all_orders
    end

  end
end




# ap Grocery::OnlineOrder.all.first











##
