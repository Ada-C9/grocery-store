require 'csv'
require 'awesome_print'

FILENAME = "orders.csv"
# data = CSV.read(FILENAME)

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0.0
      @products.each do |product, price|
        sum += price * 1.075
      end
      sum = sum.round(2)
      return sum
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        return true
        @products[:product_name] = product_price
        before_count = @products.count
        if @products.count == before_count + 1
          return true
        else
          return false
        end
      end
    end
    def self.all
    end

    def self.find(id)
    end
  end
end

CSV.open(FILENAME, 'r') do |file|
  first_line = file.readline
  puts "first line was #{first_line}"
  file.each do |product, price|
    puts "Product: #{@product}: #{@product[1]}"
  end
end
