require 'csv'

module Grocery

  class Order

    def self.all
      order_objects = []
      CSV.read("support/orders.csv").each do |line|
        products_array = line[1].split(';')

        products_array2 = []
        products_array.each do |product|
          products_array2 << product.split(':')
        end

        products_hash = products_array2.to_h
        line = Order.new(line[0], products_hash)
        order_objects << line
      end
      return order_objects
    end

    def self.find(id)
      Order.all.each do |object|
        if object.id == id
          return object
        end
      end
      return nil
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

puts Order.find("45")

end
