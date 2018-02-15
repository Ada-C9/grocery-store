module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


# gets the total plus tax of all of the products
    def total
      product_total = 0
      subtotal = 0
      @products.each_value do |prices|
        subtotal += prices
      end
      product_total = (subtotal * 0.075).round(2)+ subtotal
      return product_total





    end

# Adds new product to @product array
    def add_product(product_name, product_price)
      products = {}
      @products.each do |product_name, product_price|
        @products[product_name]= product_price
      end
      return products
    end
  end
end

new_order = Grocery::Order.new(776, {})
new_order.add_product("apple", 2.99)
new_order.add_product("pear",1.00)
new_order.add_product("banana",1.00)
new_order.total
