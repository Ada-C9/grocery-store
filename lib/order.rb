module Grocery


  class Order
    attr_reader :id, :products

    # id: Integer, represents unique identifier
    # input_products: hash that represents products with keys of product name and values of price (Float)
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total
      subtotal = @products.values.sum
      sum = subtotal + (subtotal * 0.075).round(2)
      return sum
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product

    end
  end



end
