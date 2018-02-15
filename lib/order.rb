module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.values.each do |grocery_product|
        total += grocery_product
      end
      return total + (total*0.075).round(2)
    end

    def add_product(product_name, product_price)
      confirm_value = true
      if @products[product_name] == nil
        @products[product_name] = product_price
      else
        confirm_value = false
      end
      return confirm_value
    end

  #   def remove_product(product_name)
  #     confirm = false
  #     if @products[product_name] != nil
  #        @products.delete(product_name)
  #       !confirm
  #   end
  #   return confirm
  # end

  end
end
