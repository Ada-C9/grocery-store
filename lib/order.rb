require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.inject(0, :+)
      total = sum + (sum * 0.075).round(2)
      return total
    end

    def add_product(product_name, product_price)
      if !@products.include? product_name
        @products[product_name] = product_price
        return true
      else
        return false
      end
    end

  end

end

order = Grocery::Order.new(1, { silvered_almonds: 22.88, wholewheat_flour: 1.93, grape_seed_oil: 74.9 })








# ######### ARRAY OF HASHES ###########
# orders = []
# CSV.foreach("../support/orders.csv", headers: true, headers: :symbol, headers: :converter) do |row|
#   orders << row
# end
#
#
# ap orders


#
# orders = []
# CSV.foreach("../support/orders.csv", headers: true) do |row|
#
# #orders.push(row)
#   # row.each do |i|
#
#
#
#   #ap orders
#   #puts orders[0]
#   #ap orders
#   ap row
# end

#puts orders[2]

# orders.each do |i|

# product.each_with_index do |array, index|
#   puts "#{index}. #{array}"
# end


#test1 = Grocery::Order.new(products[:], products)
