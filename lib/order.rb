module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
