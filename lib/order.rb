module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @TAX = 0.075
      @total = 0.00
      @tax_owed = 0.00
      @sub_total = 0.00
    end

    def total
      # TODO: implement total
      @products.each do |product, cost|
        @sub_total += cost
      end
      return @sub_total

      @tax_owed = @sub_total * @TAX
      @total = @tax_owed + @sub_total
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
# puts new_order.total
# new_order.add_product("cake", 5.00)
# puts products
