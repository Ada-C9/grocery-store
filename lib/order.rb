module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      #should becollection
      # only one of each product
      # zero products is permitted
    end


    #A total method which will calculate the total cost of the order by:
    # summing up the products
    # adding a 7.5% tax
    # ensure the result is rounded to two decimal places
    def total
      sum = 0

      @products.values.each do |price|
        sum += price
      end
      # sum = products.values.inject(0, :+)

      total = sum + (sum * 0.075)

      return total.round(2)
    end


    # add_product method which will take in two parameters, product name and price, and add the data to the product collection
    # It should return true if the item was successfully added and false if it was not
    def add_product(product_name, product_price)

      @products[product_name] = product_price

      @products.values.include?("product_name") ? (return true) : (return false)
    end

    def remove_product(product_name)

      @products.delete(product_name)

      @products.values.include?(product_name) ? (return true) : (return false)
    end

  end
end
