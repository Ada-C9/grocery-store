require 'csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      sum = @products.values.sum
      expected_total = sum + (sum * 0.075).round(2)
      return expected_total
    end


    def add_product(product_name, product_price)

      return false if @products.has_key?(product_name)
      @products[product_name] = product_price
      p @products
      # else
      return true
    end

    def remove_product(product_name)
      p @products
      if @products.key?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all
      all_orders = []
      CSV.open("support/orders.csv", 'r').each do |line|
        all_orders << line
      end
      return all_orders
      # returns a collection of `Order` instances, representing all of the Orders described in the CSV
    end
#
      # id = ?
      # products = ?
      # all_orders << Order.new(id, products)
      # all_orders <- how to populate it with the CSV data
      # every element in the array is an Order instance


    def self.find(id)
      # returns an instance of `Order` where the value of the id field in the CSV matches the passed parameter
      all_orders = Order.all

      # Error handling, what if it calls for an ID that DNE?
    end

  end
end

class Customer

  def initialize (id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    # returns a collection of `Customer` instances, representing all of the Customer described in the CSV.

  end

  def self.find(id)
    # returns an instance of `Customer` where the value of the id field in the CSV matches the passed parameter
  end

end
#
class OnlineOrder
  # woah woah woah, lets revisit this section later
end
