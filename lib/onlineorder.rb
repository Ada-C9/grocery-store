require 'csv'
require_relative 'order.rb'

module Grocery

  class OnlineOrder < Order

    attr_reader :id, :products, :customer, :status

    def initialize(id, products, customer, status)
      super(id, products)
      @customer = customer
      @status = status
    end

    def self.all
      oorder_objects = []
      CSV.read("support/online_orders.csv").each do |line|
        # products_array = line[1].split(';')
        #
        # products_array2 = []
        # products_array.each do |product|
        #   products_array2 << product.split(':')
        # end
        # products_hash = products_array2.to_h
        # line = OnlineOrder.new(line[0], products_hash, line[2], line[3].to_sym)
        # oorder_objects << line
        oorder_objects << self.new(line[0], self.to_products(line[1]), line[2], line[3].to_sym)
      end
      return oorder_objects
#
    end

    def self.find_by_customer(customer)
      self.all.each do |object|
        if object.customer.to_i == customer
          return object
        end
      end
      return nil
    end

    def total
      if super > 0
        return super + 10
      else
        return 0
      end
    end

    def add_product(product_name, product_price)
      if @status == :paid || @status == :pending
        super
      else
        return nil
      end

    end


  end


end
