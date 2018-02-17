require 'csv'
require 'awesome_print'
require 'pry'

FILE_NAME = "support/orders.csv"

# data = CSV.read(FILE_NAME)
# ap data
#
# data.each do |product|
#   puts " Product #{product[0]}: #{product[1]}"
# end

# CSV.open(FILE_NAME, 'r').each do |product|
# #  file.each do |product|
#     puts " Product #{product[0]}: #{product[1]}"
# #  end
# end

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # def total
    #   sum = products.values.inject(0, :+)
    #   total = sum + (sum * 0.075).round(2)
    #   return total
    # end

    def total
      sum = 0
      total = 0
      @products.each_value do |price|
        sum += price
      end
      return total = sum + (sum * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end



    def self.all
      products = []
      CSV.open(FILE_NAME, 'r').each do |product|
        line_hash = {}
        id = product[0]
        each_line = product[1].split(%r{;\s*})

        each_line.each do |hash|
          pairs = hash.split(%r{:\s*})
          line_hash[pairs[0]] = pairs[1].to_f
        end
        order = Order.new(id, line_hash)
        products << order
      end
      return products
    end

    def self.find(id)
      order_id = nil
      self.all.each do |order|
        if order.id == id
          order_id = order
        end
      end
      if order_id == nil
        return nil
      else
        return order_id
      end
    end
  end
end


ap Grocery::Order.all
#   puts " Product #{product[0]}: #{product[1]}"
#   products << Order.new(product[0], product[2])
# end
