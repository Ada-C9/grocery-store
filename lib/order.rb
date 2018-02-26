require 'csv'
require 'awesome_print'


#_______________ Grocery::Order _______________

module Grocery
  class Order

    attr_reader :id, :products

    # Initialize class Order:
    def initialize(id, products)
      @id = id
      @products = products
    end


    #############################################################################################
    # ALL ORDERS:

    # Populates itself with the whole order.csv file:
    def self.all

      @all_orders = []

      # Read file:
      # ???? Somehow I keep on getting an error here if i use only '../support/orders.csv'
      file_to_read = CSV.read('support/orders.csv', 'r')

      file_to_read.each do |row|

        #Select the order id number from the file and assign it:
        order_id = row[0].to_i

        # Separete the elements after the first comma (index[1]) into {product_name, product_price} and assign it to a products variable:
        products = separate("#{row[1]}".split(';'))

        # Push this new order (order id, products(itens, price)) to the array of orders
        new_order = Order.new(order_id, products)
        @all_orders << new_order
      end
      return @all_orders
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


    #############################################################################################
    # FIND ORDER:

    # Find order where the value of the id fiedl matches the passed parameter
    def self.find(find_id)
      all_orders = self.all
      all_orders.count.times do |order|
        if (order + 1) == find_id
          return all_orders[order]
          # "Order #{@all_orders[order][0]}: products: #{@all_orders[order][1]}"
        end
      end
      return "Order doesn't exist!"
    end

    #############################################################################################
    #  TOTAL OF ORDER:

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

    #############################################################################################
    #  ADD/REMOVE PRODUCT TO ORDER:

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
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

  end
end
