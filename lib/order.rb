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


    # Separete the elements into (product_name, product_price):
    def self.separate(elements_of_order)
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
      # ap "this is products #{products}"
      return products
    end


    # Populates itself with the whole order.csv file:
    def self.all
      # Read file:
      orders = []

      # ???? why on rake I need to have the whole path here??
      CSV.read('/Users/leticiatran/Desktop/ada/c9_Ampers/ruby_projects/mini_projects/grocery-store/support/orders.csv', 'r').each do |row|
      # CSV.read('../support/orders.csv', 'r').each do |row|

        #Select the order id number from the file and assign it:
        order_id = row[0]

        # Separete the elements after the first comma (index[1]) into {product_name, product_price} and assign it to a products variable:
        products = separate("#{row[1]}".split(';'))
        # example => puts products = [{"Allspice"=>"64.74"}, {"Bran"=>"14.72"}, {"UnbleachedFlour"=>"80.59"}]

        # Push this order (order id, products(itens, price)) to the array of orders
        orders << [order_id, products]
      end
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

# order = Grocery::Order.separate
# order = Grocery::Order.all
# ap order.class
# ap order
