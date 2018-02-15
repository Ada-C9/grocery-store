module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075).round(2)
    end

    def add_product(product_name, product_price)

      @products.each do |product_name, product_price|
        if @product_name != product_name
        @products[product_name] = product_price
        end
      end
    end
  end
end
