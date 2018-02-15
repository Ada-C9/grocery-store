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
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075)
      total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products[product_name]
        false
      else
        @products[product_name] = product_price
        true
      end
    end

    def remove_product(product_name)
      @products.delete(product_name)
      if @products[product_name]
        false
      else
        true
      end
    end

  end
end
