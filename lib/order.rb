require 'pry'
require 'csv'
require 'awesome_print'

module Grocery
  FILE_NAME = 'support/orders.csv'

  class Order
    attr_reader :id
    attr_accessor :products


    def initialize(id, products_hash)
      @id = id.to_i
      @products = products_hash
    end

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
        products_split = order[1].split(';') # products_split - array of "product:price"
        products_split.each do |mash|
          split = mash.split(':')
          products_hash[split[0]] = split[1].to_f
        end
        new_order = self.new(order[0], products_hash)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(id)
      # wouldn't self.all generate all the information again? Can't I have that as a class variable?
      all.each do |order|
        if order.id == id
          found_order = order
          return found_order
        end
      end
      return nil # need this to be here so as to complete the iteration of the all loop then return nil
    end # self.find

  end # order

end # Grocery

# binding.pry
# p Grocery::Order.find(120)
