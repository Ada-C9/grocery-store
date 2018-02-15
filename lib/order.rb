module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def values
      products.each { |product, price| extract_price_value(price) }
      return price
    end

    def subtotal
      total = values.sum

      if @products.length == 0
        return "Returns a total of zero if there are no products"
      end

      return subtotal
    end

    def tax
      return subtotal * 0.075
    end

    def total
      return subtotal + tax
    end

    #
    # def add_product(product_name, product_price)
    #   # TODO: implement add_product
    # end
  end
end
