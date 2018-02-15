module Grocery

  class Order
    attr_accessor :id, :products

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
      return product_total = (sub_total * 0.075).round(2) + sub_total.round(2)
    end


    def add_product(product_name, product_price)
      # An add_product method which will take in two parameters,
      # product name and price, and add the data to the product collection
      # It should return true if the item was successfully added and false
      # if it was not
      return false if @products.has_key?(product_name)
      # else
        @products[product_name] = product_price
        #
        # puts "products is #{@products}"
        return true
      # end

    end

  end # class Order

end # module Grocery

products = { "banana" => 1.99, "cracker" => 3.00, "sushi" => 5.50 }
order = Grocery::Order.new(1337, products)
order.add_product("takoyaki", 7.50)
puts order.products
puts order.total












# Go! Luxi! Go!
