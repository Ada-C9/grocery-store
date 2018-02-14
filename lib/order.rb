module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.each do |k,value|
        sum += value
      end
      sum = (sum + (sum * 0.075)).round(2)
    end

    def add_product(product_name, product_price)

      return false if @products.keys.include?(product_name)

      @products[product_name] = product_price

      return true
    end
  end
end
