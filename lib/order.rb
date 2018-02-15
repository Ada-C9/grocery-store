module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      ((@products.values.sum) * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include? (product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include? (product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end
  end
end
