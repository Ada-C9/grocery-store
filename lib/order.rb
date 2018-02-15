module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      @total = 0.00
    end

    def total
      # TODO: implement total
      sub_total = 0.00
      @products.each do |product, cost|
        sub_total += cost
      end
      # return sub_total

      @total = sub_total + (sub_total * @tax).round(2)
      return @total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
      beginning_length = @products.length
      @products[product_name] = product_price
      if @products.length > beginning_length
        return true
      else
        return false
      end
    end
  end
end

# products = { :apple => 1.25, :pear => 2.00 }
# new_order = Grocery::Order.new(12345, products)
# # new_order.add_product("cake", 5.00)
# # puts new_order.total
# puts new_order.add_product("banana", 4.25)
# puts products
