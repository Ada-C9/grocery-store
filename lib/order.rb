module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      if @products.length == 0
        return total = 0
      end
      sum  = @products.values.inject(0, :+)
      total = sum + (sum * 0.075)
      return total.round(2)
    end


  end
end
