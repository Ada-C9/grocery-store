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
      current_products = @products.keys
      if current_products.include? (product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end # end of add_product method
  end # end of class order
end # end of module grocery
