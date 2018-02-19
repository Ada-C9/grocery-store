require 'csv'
require 'awesome_print'
require 'pry'


module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      total = 0
      @products.each do |k, v|
        total += v
      end
      return (total * 1.075).round(2)
    end

    def add_product(product_name, product_price)

      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def self.all
      all_orders = []
      CSV.read("support/orders.csv").each do |row| # order - array

        id = row[0].to_i # make id an integer
        products_split = row[1].split(';') # products_split - array of product/price
        products_hash = {} # this will become @products when making new instances
        products_split.each do |product|# loop through products array
          product_pair = product.split(':')
          #put all in a hash
          products_hash[product_pair[0]] = product_pair[1].to_f
        end
        new_order = Order.new(id, products_hash)
        all_orders << new_order
      end
      return all_orders
    end

    def self.find(id)
      all_orders = Order.all
      all_orders.each do |entry|
        if entry.id == id
          return entry.products
        end
      end
      return nil
    end #end self find method

  end # end Order class
end # end Grocery module

binding.pry
