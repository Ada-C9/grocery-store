require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products

    # @@all_orders = []


    # Initialize class Order:
    def initialize(id, products)
      @id = id
      @products = products
    end


    def self.all
      # Read file:
      orders = []
      CSV.read('../support/orders.csv', 'r').each do |row|

        #Select the order number and assign it:
        order_id = row[0]
        # ap order_id

        # Selec the order element (product, price) and assign it:
        elements_of_order = "#{row[1]}".split(';')

        # ap elements_of_order.class
        # ap elements_of_order

        # Separete the elements into (product_name, product_price):
        products = {}
        elements_of_order.each do |item|

          # Assign the product of this element in this order:
          product =  "#{item.split(':')[0]}" #.split.map(&:capitalize).join(' ')
          # puts "product : #{product}"

          # Assign the price of this element in this order:
          price =  "#{item.split(':')[1]}"
          # puts "price : #{price}"

          #Push the Product and the Price into the array products for this order:
          products["#{product}"] = price.to_f
          # puts "products: #{products}"

        end

        # Push this order to the array od orders
        orders << [order_id, products]
        # puts products # = [{"Allspice"=>"64.74"}, {"Bran"=>"14.72"}, {"UnbleachedFlour"=>"80.59"}]
      end
      # ap orders
      return orders
    end



    # Total of order with tax:
    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      # sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075)
      return total.round(2)
    end


    # Add a new product to order:
    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Remove product from order:
    def remove_product(product_name)
      @products.delete(product_name)
      if @products.values.include?(product_name)
        return true
      else
        return false
      end
    end

  end
end

# order = Grocery::Order.all
# ap order.class
