module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products

    end

    def values
      products.each { |key,value| do_something(value) }
      return values
    end

    def total
      total = values.sum

      if @products.length == 0
        return "Returns a total of zero if there are no products"
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
