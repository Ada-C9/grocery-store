module Grocery
  class Order
    require 'csv'
    attr_reader :id, :products
   CSV.read("orders.csv")
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.each_values do |value|

        sum += value
        total = sum + (sum * 0.7).round(2)
      end
      # TODO: implement total
      return expected_total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product

       #@products[:product_name] = product_price
       if @products.keys.include?(product_name)
         return false
       else
         return true
    end
  end
end
end
