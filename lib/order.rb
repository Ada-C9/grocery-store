module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    # def values
    #
    # end

    def total
      total = @products.sum

      if @products.length == 0
        return "BLAH"
      end

      return total

      # TODO: implement total

    end
    #
    # def add_product(product_name, product_price)
    #   # TODO: implement add_product
    # end
  end
end
