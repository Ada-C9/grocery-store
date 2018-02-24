require "csv"
require "pry"

FILE_NAME = "support/orders.csv"

module Grocery
  class Order
    attr_reader :id
    attr_accessor :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075).round(2)
    end

    def add_product(product_name, product_price)
      current_products = @products.keys
      if current_products.include? (product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end # end of add_product method

    def self.all
      all_orders = []
      CSV.read("support/orders.csv").each do |row|
        products = {}
        products_information = row.last.split(';')
        products_information.each do |prod_info|
          split_prod_info = prod_info.split(':')
          name = split_prod_info[0]
          price = split_prod_info[1]
          products[name] = price
          order = Order.new(row.first, products)
          all_orders << order
        end
      end
      return all_orders
    end # end of self.all method

    def self.find(order_id)
      self.all.each do |order|
        if order.id == order_id
          return order
        end
      end
      return nil
    end # end of self.find

  end # end of class order
end # end of module grocery
