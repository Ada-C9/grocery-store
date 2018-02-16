module Grocery

  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end
    def add_product(product, price)
      before_count = @products.count
      @products = @products.merge(product => price)
      before_count + 1 == @products.count
    end
    def remove_product(product)
      before_count = @products.count
      @products.delete(product)
      before_count - 1 == @products.count
    end
    def total
      sum = @products.values.inject(0, :+)
      sum_with_tax = expected_total = sum + (sum * 0.075).round(2)
      return sum_with_tax
    end
  end
end


#first_order = Grocery::Order.new(1337, {})
#puts first_order.add_product("banana", 2.15).inspect
#puts first_order.product.inspect
