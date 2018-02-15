require 'pry'

module Grocery

  class Order
    attr_reader :id
    attr_accessor :products
    @@order_count = 0
    @@all_orders = []

    def initialize(id, products_hash)
      @id = id.to_i
      @products = products_hash
      @@order_count += 1
      @new_order_hash = Hash.new
      @new_order_hash[@id] = @products
      @@all_orders << @new_order_hash

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
      @@all_orders
    end

  end # order

end # Grocery

binding.pry
