module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.each do |k, v|
        total += v
      end
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product

      if @products.key? product_name
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end
