require_relative '../lib/order'

require 'csv'
require 'awesome_print'

module Grocery
  class  OnlineOrder < Grocery::Order
    attr_reader :id, :products, :customerid, :status

    #overwrites initialize method for Order
    def initialize(id, products)
      @id = id
      @products = products
      @customerid = customerid
      @status = status
    end


    #overwrites all method for Order
    def self.all
      osnline_online_orders_csv = CSV.read("support/online_orders.csv", 'r',headers: true).to_a

      return online_orders_csv
    end

    #overwrites .find method for Order class
    def self.find(id)
      online_online_orders_csv = CSV.read("support/online_orders.csv", 'r',headers: true).to_a

      if id > online_orders_csv.length
        return nil
      end

      if id >=1
        specific_online_order = online_orders_csv [id-1]
      elsif id < 0
        specific_online_order = online_orders_csv[id]
      else
        return nil
      end
      return specific_online_order
    end




    def total
      sum = 0
      if !(@products.empty?) || @products !=  nil
        @products.each do |product, cost|
          sum += cost
        end
        sales_tax = 0.075
        sum = (sum + (sum * sales_tax)).round(2)
      end
      return sum
      # TODO: implement total
    end

    def add_product(product_name, product_price)
      if @products.has_key? product_name
        return false
      else
        @products[product_name] = product_price
        return true
        # TODO: implement add_product
      end
    end

    def remove_product(product_name)
      @products.delete(product_name)
      if @products.has_key? product_name
        return false
      end

    end
  end

end
