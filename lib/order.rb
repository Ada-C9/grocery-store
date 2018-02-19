require 'CSV'
require 'awesome_print'


module Grocery

  class Order
    attr_accessor :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      ((@products.values.sum) * 1.075).round(2)
    end

    def add_product(product_name,product_price)
      @products = products

      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end

    end

    def remove_product(product_name)
      if @products.keys.include? (product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end



# wave2
    def self.all
      all_orders = []
      CSV.open('support/orders.csv', 'r').each do |order|
        product_hash = {}
        id = order[0].to_i
        order[1].split(";").each do |pair|
          new_pair = pair.split(":")
          key = new_pair[0]
          value = new_pair[1].to_f
          product_hash[key] = value
        end
        new_order = Order.new(id, product_hash)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(id)
      @id = id
      Grocery::Order.all.each do |order|
        if order.id == id
        return order
        end
       #if order.id == nil
       raise  ArgumentError.new("Id does not exists")
     end
    end
  end
end
