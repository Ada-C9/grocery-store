module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

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

    # def remove_product(product_name)
    #   @products.delete_if {|product, value| product == product_name }
    #
    #   if @products.keys.include?(product_name)
    #     return false
    #   else
    #     return true
    #   end
    # end

    def remove_product(product_name)
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
