require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products


    def initialize(id, products)
      @id = id
      @products = products
    end


    def self.all
      orders = []
      # "This is a class method."
      # This is a class method to access the class variabel
      #returns the csv file to an array with headers
      #orders_csv = CSV.read('support/orders.csv', 'r')
      orders_csv = CSV.read("support/orders.csv", 'r',headers: true).to_a


      orders_csv.each do |line|
        orders << Grocery::Order.new(*line)
      end
      return orders
    end


    def self.find(id)
      a = self.all

      if id > a.length
        return nil
      end

      if id >=1
        specific_order = a[id-1]
      elsif id < 0
        specific_order = a[id]
      else
        return nil
      end
      return specific_order
    end




    def self.total
      a = self.all
      sum = 0
      #put in a class level variable for total
      if !(a.products.empty?) || a.products !=  nil
        a.products.each do |product, cost|
          sum += cost
        end
        sales_tax = 0.075
        sum = (sum + (sum * sales_tax)).round(2)
      end
      return sum
      # TODO: make changes where sum is returned
    end


    def add_product(product_name, product_price)
      a = self.all
      if a.products.has_key? product_name
        return false
      else
        a.products[product_name] = product_price
        return true
        # TODO: implement add_product
      end
    end

    def remove_product(product_name)
      a = self.all
      a.products.delete(product_name)
      if a.products.has_key? product_name
        return false
      end

    end


  end
end
