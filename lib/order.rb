require 'awesome_print'
require 'csv'
module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id.to_i
      @products = products
    end

    def total
      if @products.length == 0
        return total = 0
      end
      sum  = @products.values.inject(0, :+)
      total = sum + (sum * 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.read("support/orders.csv").each do |line|
        id = line[0].to_i
        products = {}
        products_hash = line[1].split(";")

        products_hash.each do |product|
          split_product = product.split(":")
          item = split_product[0]
          price = split_product[1].to_f
          product_hash = {item => price}
          products.merge!(product_hash)
        end
        all_orders << Grocery::Order.new(id, products)
      end
      return all_orders
    end

    def self.find(id)
      self.all.each do |order|
        return order if order.id == id
      end
      return nil
    end

  end
end
