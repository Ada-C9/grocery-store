module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      @name = name
      @price = price
    end

    def total
      sum = 0.0
      @products.each_value do |pv|
        # p = "cracker" => 3.00
          sum = sum + pv
      end

      tax = sum * @tax
      sum_with_tax = tax + sum
      rounded_decimal = sum_with_tax.round(2)
      return rounded_decimal
    end

    def add_product (name,price)
       if @products.key? name
         return
         false
       else
         @products[name] = price
        return
         true


      end
    end
  end
end




    #  for each product get the value of each product and
    # the number of values

     # for each product get the price and the
     # the number of the item ordered
     #describe "#total" do
      # it "Returns the total from the collection of products" do
      #   products = { "banana" => 1.99, "cracker" => 3.00 }
      #3   order = Grocery::Order.new(1337, products)
     #
      #   sum = products.values.inject(0, :+)
      #   expected_total = sum + (sum * 0.075).round(2)

      #   order.total.must_equal expected_total
       #end







       #puts


  #  end

  #  def add_product(product_name, product_price)

  #  end
#  end
#end

# order = Grocery::Order.new( 1337, {})
# products = { "banana" => 1.99, "cracker" => 3.00 }
# order = Grocery::Order.new(1337, products)
# puts products
