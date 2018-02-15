module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = 0
      @products.each do |key, value|
        subtotal += value
      end
      total = subtotal * (1 + 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      before_count = @products.length
      if @products.keys.include?(product_name)
        return false
      end
      @products[product_name] = product_price
      if @products.length == before_count + 1
        return true
      else
        return false
      end
    end

    def remove_product(product_name)
      # TODO: implement remove_product
      before_count = @products.length
      if !@products.keys.include?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end
  end
end
