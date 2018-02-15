require 'pry'
require 'csv'
require 'awesome_print'

module Grocery

  class Order
    attr_reader :id
    attr_accessor :products

    FILE_NAME = 'support/orders_test.csv'

    def initialize(id, products_hash)
      @id = id.to_i
      @products = products_hash
      # @products_string = products_string
      # products_string_to_hash
    end

    # def products_string_to_hash
    #   products_split = @products_string.split(';')
    #   products_split.each do |mash|
    #     split = mash.split(':')
    #     @products[split[0]] = split[1]
    #   end
    # end

    def subtotal
      subtotal = 0
      @products.each do |item, price|
        subtotal += price
      end
      return subtotal
    end

    def total
      total = subtotal + (0.075 * subtotal)
      total = total.round(2)
      return total
    end

    def add_product(item, price)
      unless @products.keys.include?(item)
        @products[item] = price
        return true
      else
        return false
      end
    end

    def remove_product(item)
      if @products.keys.include?(item)
        @products.delete(item)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.open(FILE_NAME, "r").each do |order| # order - array
        products_hash= {}
        # order[1].each do |string| # string - string
          products_split = order[1].split(';') # products_split - array of "product:price"
          products_split.each do |mash|
            split = mash.split(':')
            products_hash[split[0]] = split[1]
          end
        new_order = Order.new(order[0], products_hash)
        all_orders << new_order
      end
      return all_orders
    end

  end # order

end # Grocery

# all_orders = CSV.read('../support/orders_test.csv')
# ap all_orders

binding.pry
