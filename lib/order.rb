require 'faker'
require 'ap'


module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = Grocery::ProductList.new.populate_products
    end

    def summary
      print "Here are the Products"
      ap @products
    end

    def total
      # TODO: implement total
    end

    def add_product(product_name, product_price)
      # TODO: implement add_product
    end

  end


  class ProductList
    attr_reader :products

    def initialize
      @products = {}
    end

    def populate_products
      10.times do
        food_name = Faker::Food.ingredient
        @products[:food_name] = rand(0.0..10.0).round(2)
        # print "food_name #{food_name}\n"
        # print "cost : #{@products[:food_name]}\n"
        # print "***********************\n"
      end
      return @products
    end
  end

end


thisorder = Grocery::Order.new(1, {})

puts thisorder.summary


# thisgroceries = Grocery::ProductList.new
#
# puts thisgroceries.populate_products
