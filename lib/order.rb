require 'csv'
require 'pry'
require 'awesome_print'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      product_total = 0
      subtotal = 0
      @products.each_value do |prices|
        subtotal += prices
      end
      product_total = subtotal + (subtotal * 0.075).round(2)
      return product_total
    end


    def add_product(product_name, product_price)
      if @products.include?(product_name)

        return false
      else
        @products[product_name] = product_price

        return true
      end
      return products
    end

    def self.all
      all_data = []

      all_orders = CSV.open("../support/orders.csv", 'r')

      all_orders.each do |file|
        @id = file[0].to_i

        item = file[1].split(';')
        item_price = item.map! do |row|
          Hash[row.split(':').first,row.split(':').last]
        end
        item_price = item_price.reduce(:merge)
        @products = item_price

        all_data << Order.new(@id, @products)
      end

      return all_data
    end

    def self.find(id)
      all_orders = Grocery::Order.all

      all_orders.each do |item|
        if item.id == id
          return item.products
        end
      end
      return nil
    end


  end
end
