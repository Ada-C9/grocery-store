module Grocery

  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end


    def total
      # A total method which will calculate the total cost of the order by:
      # summing up the products
      # adding a 7.5% tax
      # ensure the result is rounded to two decimal places
      product_total = 0
      sub_total = 0
      @products.each_value do |prices|
        sub_total += prices
      end
      return product_total = (sub_total * 0.075).round(2) + sub_total
    end


    def add_product(product_name, product_price)
      # An add_product method which will take in two parameters,
      # product name and price, and add the data to the product collection
      # It should return true if the item was successfully added and false
      # if it was not

    end

  end # class Order

end # module Grocery
