require 'csv'
require 'awesome_print'
require 'money'
I18n.enforce_available_locales = false

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      cents_with_tax = (sum + (sum * 0.075))*100.round
      sum_with_tax = Money.new(cents_with_tax, "USD")
      return sum_with_tax
    end

    def add_product(product_name, product_price)
      if @products.has_key?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      orders_entered = []
      CSV.read("/Users/brandyaustin/ada/week2/grocery_store/grocery-store/support/orders.csv").each do |row|
        id = row[0].to_i
        products = {}
        products_array = row[1].split(";")

        products_array.each do |item|
          name, price = item.split(':')
          products[name] = price.to_f
        end
        orders_entered << Order.new(id, products)
      end
      return orders_entered
    end

    def self.find(id)
      orders_entered = self.all
      orders_entered.each do |order|
        if order.id == id
          return order
        end
      end
      return nil
    end

  end
end
