require 'csv'

module Grocery

  class Order

    def self.all
      order_objects = []
      CSV.read("orders.csv").each do |line|
        products_array = line[1].split(';')

        products_array2 = []
        products_array.each do |product|
          products_array2 << product.split(';')
        end

        products_array3 = []
        products_array2.each do |product|
          product.each do |i|
            products_array3 << i.split(':')
          end
        end
        products_hash = products_array3.to_h
        line = Order.new(line[0], products_hash)
        order_objects << line
      end
      return order_objects
    end

    def self.find(id)
      Order.all.each do |object|
        if object.id == id
          return object
        else
          return nil
        end
      end
    end

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |item, price|
        subtotal += price.to_f
      end
      return (subtotal * 1.075).round(2)
    end

    def add_product(product_name, product_price)
      if @products.key?(product_name)
        return !@products.key?(product_name)
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.key?(product_name)
        @product.delete(product_name)
        return true
      else
        return false
      end
    end


  end
# first = Order.all[0]
# puts first.products
object_1 = Order.find("1")
puts object_1.products
puts object_1.total
end
