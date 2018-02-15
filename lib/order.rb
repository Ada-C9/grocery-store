module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      product_total = 0
      subtotal = 0
      @products.each_value do |prices|
        subtotal += prices
      end
      product_total = subtotal + (subtotal * 0.075).round(2)
      return product_total
    end

    def add_product(product_name, product_price)
      products = {}
        @products[product_name] = product_price
      return products
    end
  end
end

new_order = Grocery::Order.new(1234, {})
new_order.add_product("grapes", 3.00)
new_order.add_product("crackers", 1.00)
new_order.add_product("yogurt", 0.99)
new_order.total
