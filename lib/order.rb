require 'csv'
require 'awesome_print'

FILE_NAME = "../support/orders.csv"

module Grocery
  class Order
    attr_reader :id, :products

    products = [] #adding products as an array of hashes
    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      @total = 0.00
    end

    def self.all
      all = []
      CSV.open(FILE_NAME, "r").each do |line|
        all << line
      end
      return all
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
      if @products.key?(product_name) #method to see if the product already exists in product hash
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end
  end
end

# my_order = Grocery::Order.new(1,[{"Slivered Almonds" => 22.88},{"Wholewheat flour" => 1.93},{"Grape Seed Oil" => 74.9}])
# puts my_order
# puts Grocery::Order.all
# puts Grocery::Order.all.inspect
