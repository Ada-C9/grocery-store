require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def self.all
      print "This is a class method."
      #returns the csv file to an array with headers
      #orders_csv = CSV.read('support/orders.csv', 'r')
      orders_csv = CSV.read("support/orders.csv", 'r',headers: true).to_a
      #ap orders_csv
      #ap orders_csv.length

      return orders_csv
    end

    def initialize(id, products)
      @id = id
      @products = products
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

#with a class method you don't need the instance of the class
#Grocery::Order.all
 last_order = CSV.open('support/orders.csv', 'r').to_a

 ap last_order[1]
