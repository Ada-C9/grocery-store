module Grocery
  class Order
    attr_reader :id, :products

    # param id - order id (integer)
    # param products - {} of products and costs
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      return subtotal + tax
    end

    # Subtotal method to calculate products cost
    def subtotal
      subtotal = 0
      @products.each_value do |price|
        subtotal += price
      end
      return subtotal.round(2)
    end

    # Tax method to calculate products taxes
    def tax
      tax = 0
      tax_rate = 0.075
      @products.each_value do |price|
        tax += price * tax_rate
      end
      return tax.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Create a remove_product method to check if a product is removed
    def remove_product(product_name)
      if @products.keys.include?(product_name)
        return false
        @products.keys.delete(product_name)
      else
        return true
      end
    end

  end
end
