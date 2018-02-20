require 'awesome_print'
require 'csv'

module Grocery
  class Order
    attr_reader :id
    attr_accessor :order, :products

    @@organized_orders = []

    def initialize (id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      tax = subtotal * 0.075
      total = (subtotal + tax).round(2)
      return total
    end
    # Takes user input product, price and order id
    # Allows user to add new order, or add product and its price to existing order
    # Appends new order onto existing orders csv file
    def add_product(product_name, product_price, add_id)
      if add_id != "new"
        add_id = add_id.to_i
        add_products = self.find_by_id(add_id)
        if !add_product == false
          add_products.each do |product, price|
            if add_product == product
              puts "The product has already been added."
              return false
            else
              add_products.store(product_name, product_price)
              puts "#{product_name} has been added to #{add_id}"
              return true
            end
          end
        else
          new_id = orders.length + 1
          new_products = {product_name => product_price}
          CSV.open("../support/orders.csv", 'a') do |orders_csv|
            orders_csv << ["#{new_id}", "#{product_name}:#{product_price}"]
          end
          @@organized_orders << Order.new(new_id, new_products)
        end
      end
    end

    def self.find(find_id)
      found_order = false
      @@organized_orders.each do |order|
        if order.id == find_id
          found_order = order.products
        end
      end
      return found_order
    end

    def self.all
      array_of_orders_data = CSV.read("../support/orders.csv")
      array_of_orders_data.each do |order|
        products = Hash.new
        id = order[0].to_i
        product_prices = order[1].split(";")
        product_prices.each do |product_price|
          product_price = product_price.split(":")
          products.store(product_price[0], product_price[1].to_f)
        end
        @@organized_orders << Order.new(order[0].to_i, products)
      end
      # I comment this out after running rake
      # return array_of_orders_data
    end
  end
end

puts Grocery::Order.all
