require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products

    @@total_order = 0 

    def initialize(id, products)
      @id = id
      @products = products
    end


    def self.all
      # "This is a class method."
      #returns the csv file to an array with headers
      #orders_csv = CSV.read('support/orders.csv', 'r')
      orders_csv = CSV.read("support/orders.csv", 'r',headers: true).to_a
      #ap orders_csv
      #ap orders_csv.length

      return orders_csv
    end

    def self.find(id)
      orders_csv = CSV.read("support/orders.csv", 'r',headers: true).to_a

      if id > orders_csv.length
        return nil
      end

      if id >=1
        specific_order = orders_csv [id-1]
      elsif id < 0
        specific_order = orders_csv[id]
      else
        return nil
      end
      return specific_order
    end



    #don't need change everything to reflect the self.total, assumes self.total
    def total
      sum = 0
      #put in a class level variable for total
      if !(@products.empty?) || @products !=  nil
        @products.each do |product, cost|
          sum += cost
        end
        sales_tax = 0.075
        sum = (sum + (sum * sales_tax)).round(2)
      end
      @@total_order = sum
      return sum
      # TODO: make changes where sum is returned
    end

    def self.total_order
      return @@total_order
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
