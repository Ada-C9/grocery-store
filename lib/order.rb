module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return total = 0
      end
      sum  = @products.values.inject(0, :+)
      total = sum + (sum * 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

  end
end
