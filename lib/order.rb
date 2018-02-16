module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    # gets the total plus tax of all of the products
    def total
      product_total = 0
      subtotal = 0
      @products.each_value do |prices|
        subtotal += prices
      end
      product_total = (subtotal * 0.075).round(2)+ subtotal
      return product_total

    end
    # Adds new product to @product array
    def add_product(product_name, product_price)

      if @products.include?(product_name)

        return false
      else
        @products[product_name]= product_price
        return true
      end
      return products

    end
  end
end
