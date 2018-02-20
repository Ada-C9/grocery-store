module Grocery
  class Order
    #an ID, read-only, products are currently read only too
    attr_reader :id, :products

    #Define initialize
    def initialize(id, products)
      @id = id
      @products = products
      @product_length = @products.length
      return @products
    end

    #Define the total method, which will calculate the total cost of the order
    #by summing up the products, and adding 7.5% tax
    #needs rounding by 2 decimal places.
    def total
      # TODO: implement total
      @total = 0
      @products.each do |products, price|
        @total += price + price *(0.075)
      end
      #Round by two, make sure total can be accessed outside
      return @total.round(2)
    end

    #Define the add product method, take in two arguments, product_name and product_price, and add the data to the product collection
    #It should return true if the item was successfully added and false if it was not
    def add_product(product_name, product_price)
      # TODO: implement add_product
      #will not add product if it already is there
      @products.each do |products, price|
        if products == product_name
          return false
        end
      end
      #Add the product name if it is a new product
      @products[product_name] = product_price
      return true
      @all_products = []
      @all_products << products #seems repetitive#

    end
  end
end
