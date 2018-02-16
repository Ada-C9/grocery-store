require "csv"

# Put the name of the file in a constant
FILE_NAME = "../support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = {}
    end

# all_orders = [
#   [1,
#     {
#     A: 2.00,
#     B: 3.00
#     }
#   ],
#   [2,
#     {
#     C: 4.00
#     }
#   ]
# ]

    def self.all
      all_orders = []
      CSV.read(FILE_NAME, 'r').each do |product|
        puts product
      end 
    end

    def total
      result = 0
      @products.each_value do |value|
        result += value
      end
        result = result + (result * 0.075).round(2)
        return result
    end

    # def total-- Another way to do it!!
    #   prices = @products.values
    #   result = 0
    #   prices.each do |price|
    #     result += price
    #   end
    #   result = result + (result * 0.075).round(2)
    #   return result
    # end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      @products.delete product_name
      if @products.key?(product_name)
        return false
      else
        return true
      end
    end
  end
end

# firstOrder = Grocery::Order.new(1, {"Almonds": 22.8, "Wholewheat flour": 1.93, "Grape Seed Oil": 74.9})
# print firstOrder
puts Grocery::Order.all
