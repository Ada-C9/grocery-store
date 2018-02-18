module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      # @name = name
      # @price = price
    end

    def total
      sum = 0.0
      @products.each_value do |pv|
        # p = "cracker" => 3.00
          sum = sum + pv
      end

      tax = sum * @tax
      sum_with_tax = tax + sum
      rounded_decimal = sum_with_tax.round(2)
      return rounded_decimal
    end


    def add_product (name,price)
       if @products.key? name
         return false
       else
         @products[name] = price
        return true
      end
    end
  end
end


our_order = Grocery::Order.new(9, {"Cucumber" => 5.72,"Yoghurt" => 28.55} )
#
puts our_order.id
puts our_order.products

#
# our_string = Inventory::String.new("green", 100)
# ruby_string = String.new("ruby string")
#
# puts our_string.class
# puts ruby_string.class











# order = Grocery::Order.new( 1337, {})
# products = { "banana" => 1.99, "cracker" => 3.00 }
# order = Grocery::Order.new(1337, products)
# puts products
