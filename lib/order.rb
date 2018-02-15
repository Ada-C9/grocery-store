module Grocery
  class Order
    attr_reader :id, :products, :product_name, :product_price

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end

      total =  (subtotal + (subtotal * 0.075)).round(2)
    end

    def add_product(product_name, product_price)

      if @products.keys.include?(product_name)
        return result = false
        puts "#{@products[product_name]} was already in your cart"
      else
        @products[product_name] = product_price
        return result = true
        puts "#{@products[product_name]} added to your cart"
      end

    end
  end
end
