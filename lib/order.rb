require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products

    @@all_orders = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if !@products.include? product_name
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

    def self.all
      @@all_orders = []
      CSV.foreach("../support/orders.csv") do |row|
        row[0] = row[0].to_i
        row[1] = row[1].split(";")

        products_hash = {}

        row[1].map! do |products|
          products = products.split(":")
          products_hash[products[0]] = products[1].to_f
        end

        @@all_orders << [row[0], products_hash]

      end
      return @@all_orders
    end

    def self.find(id)
      specific_order = self.all[id - 1]
      if id <= self.all.length
        return specific_order
      else
        raise NotImplementedError
      end
    end

  end
end



ap Grocery::Order.all




###potentially add to order.all ###




#     hash = { i[0] => i[1].to_f }
#   end
# end
#  return @@all_orders
#end
