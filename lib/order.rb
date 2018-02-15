module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      # TODO: implement total

      # sum the products
      sub_total = 0
      @products.each do |product, price|
        sub_total += price
      end
      # return sub_total

      # add tax
      total = sub_total * 1.075

      # round to two decimal places
      total_round = total.round(2)

    end

    # add new product with price if not already present in list
    def add_product(product_name, product_price)
      # TODO: implement add_product
      if @products.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # remove product and price only if it already exists in list 
    def remove_product(product_name)
      if !@products.include?(product_name)
        return false
      else
        @products.delete(product_name)
        return true
      end
    end

  end # class Order

end # module Grocery



















#
