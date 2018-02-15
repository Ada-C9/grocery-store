require 'csv'

module Grocery

  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |item, price|
        subtotal += price
      end
      return (subtotal * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return !@products.key?(product_name)
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @product.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
