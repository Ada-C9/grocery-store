require 'csv'

module Grocery

  class Order

    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.to_products(csv_input)
      products = {}
      k_v_array = csv_input.split(";")

      k_v_array.each do |kv|
        key, value = kv.split(":")
        products[key] = value
      end
      return products
    end

    def self.all
      order_objects = []
      CSV.read("support/orders.csv").each do |line|
        products = self.to_products(line[1])

        new_order = Order.new(line[0], products)
        order_objects << new_order
      end
      return order_objects
    end

    def self.find(id)
      self.all.each do |object|
        if object.id == id
          return object
        end
      end
      return nil
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

end
