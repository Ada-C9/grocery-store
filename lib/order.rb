module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.sum
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end


    def add_product(product_name, product_price)
      @products[product_name] = product_price
      # p @products
      # puts "*" * 20
      # puts "products is #{@products}"
      # puts  "cracker price should be this: #{@products['cracker']}"
      return @products




    end
  end
end
