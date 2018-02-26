require_relative '../lib/order'

require 'csv'
require 'awesome_print'

module Grocery
  class  OnlineOrder < Grocery::Order
    attr_reader :customerid, :status

    #overwrites initialize method for Order
    def initialize(id, products, customerid = 1, status = :pending)
      super(id, products)
      @customerid = customerid
      @status = status
    end

    #returns a list of OnlineOrder instances where the value of the customer's ID matches the passed parameter.
    def self.find_by_customer(customer_id)
      online_orders_csv = CSV.read("support/online_orders.csv", 'r',headers: true).to_a

      if customer_id > online_orders_csv.length
        return nil
      end

      if customer_id >=1
        specific_online_order = online_orders_csv [customer_id-1]
      elsif customer_id < 0
        specific_online_order = online_orders_csv[customer_id]
      else
        return nil
      end
      return specific_online_order
    end


    #overwrites all method for Order
    def self.all
      online_orders=[]

      online_orders_csv = CSV.read("support/online_orders.csv", 'r',headers: true).to_a

      online_orders_csv.each do |line|
        online_orders << self.new(line[0].to_i,self.products_to_string(line[1]), line[2].to_i, line[3].to_sym)


      end
      return online_orders

    end

    #overwrites .find method for Order class
    def self.find(id)
      a = self.all


      # if id > online_orders_csv.length
      #   return nil
      # end
      #
      # if id >=1
      #   specific_online_order = a[id-1]
      # elsif id < 0
      #   specific_online_order = a[id]
      # else
      #   return nil
      # end
      # return specific_online_order
    end




    def self.total
      sum = super
      sum = (sum * 0.10) + sum
      # sum = 0
      # if !(@products.empty?) || @products !=  nil
      #   @products.each do |product, cost|
      #     sum += cost
      #   end
      #   sales_tax = 0.075
      #   sum = (sum + (sum * sales_tax)).round(2)
      # end
      # return sum
      # # TODO: implement total
    end

    def add_product(product_name, product_price)
      if @products.has_key? product_name
        return false
      else
        @products[product_name] = product_price
        return true
        # TODO: implement add_product
      end
      ends

      def remove_product(product_name)
        @products.delete(product_name)
        if @products.has_key? product_name
          return false
        end

      end

    end

  end
end
