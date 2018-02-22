module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end
  end
end
