require 'csv'
require 'awesome_print'
module Grocery
  class Order
    attr_reader :id, :products

    # param id - order id (integer)
    # param products - {} of products and costs
    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      return subtotal + tax
    end

    # Subtotal method to calculate products cost
    def subtotal
      subtotal = 0
      @products.each_value do |price|
        subtotal += price
      end
      return subtotal.round(2)
    end

    # Tax method to calculate products taxes
    def tax
      tax = 0
      tax_rate = 0.075
      @products.each_value do |price|
        tax += price * tax_rate
      end
      return tax.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Create a remove_product method to check if a product is removed
    def remove_product(product_name)
      if @products.keys.include?(product_name)
        return false
        @products.keys.delete(product_name)
      else
        return true
      end
    end

  end
end

#
csv_products = []
CSV.open("orders.csv", "r").each do |order|
  # product id
  ap order[0]

  # products -hashes
  products = order[1].split(%r{;\s*}) # it's an array of string
  # Split again to get two strings seperate
  products.each do |product|
    product_hash = {}
    pairs = product.split(%r{:\s*}) # an array of two string - key & value
    # Store the key value pair in a new hash - which refers to one product
    product_hash[pairs[0]] = pairs[1].to_f
    ap product_hash

  end

end

# ap csv_products









#
