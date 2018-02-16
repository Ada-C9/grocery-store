require 'csv'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.all
      # returns a collection of Order instances,
      # representing all of the Orders described
      # in the CSV

    end

    def total
      sum = 0
      @products.each do |product, price|
        sum += price
      end
      total = sum * 1.075
      return total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

  end
end

FILE_NAME = "support/orders.csv"
data = CSV.read(FILE_NAME)

# orders_hash = {}
array_of_orders = []
data.each do |order|

  id = order[0]
  items_string = order[1]
  products = {} #will take k/v delineated by semicolon
  semicolon = ';'

  semicolon_split = items_string.split(semicolon)

  semicolon_split.each do |string|
    colon = ':'
    key_value_split = string.split(colon)

    products[key_value_split[0]] = key_value_split[1]

  end
  new_order = Order.new(id,products)

end

# array_of_orders << # Order instance (i.e., NOT collection of hashes)
