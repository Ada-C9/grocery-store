require 'csv'
require 'awesome_print'

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
      sum_with_tax = (0.075 * sum + sum).round(2)
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

  # must add tests for this function
    def remove_product(product_name)
      if @products.has_key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

# self means it's related to the class rather than a specific instance
# we still want to keep this method within the class bc it's related to the class itself (or in other words, it's related to what this code is doing with respect to Order)
# use self when you want to perform an action within a class, but don't want to do so on one instance at a time...instead want to take some other action that's merely related to the class
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

  class Customer

    attr_reader :id, :email, :address

    def initialize(customer_id, email, address)
      @id = customer_id
      @email = email
      @address = address
    end

    def self.all
      customers = []
      CSV.read("/Users/brandyaustin/ada/week2/grocery_store/grocery-store/support/customers.csv").each do |row|
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

end
