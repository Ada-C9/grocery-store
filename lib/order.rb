require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products

    # @orders = []
    #
    # CSV.read('support/orders.csv', 'r').each do |row|
    #     @orders << row
    # end


    @@all_orders = []


    # Initialize Method
    def initialize(id, products)
      @id = id
      @products = []

      # products.count.times do |i|
      #   element = "#{products[i]}".split(':')
      #   @products << element
      # end

      # @item =  @products[0]
      # @price = @products[1]
      #
    end

    # Add the following class methods to your existing Order class
    # self.all - returns a collection of Order instances, representing all of the Orders described in the CSV. See below for the CSV file specifications
    # Determine if the data structure you used in Wave 1 will still work for these new requirements
    # Note that to parse the product string from the CSV file you will need to use the split method
    def self.all
      if @@all_orders.empty?

        full_order = []
        products = []

        CSV.read('../support/orders.csv', 'r').each do |row|

          id = row[0].to_i
          full_order << "#{row[1]}".split(';')


          full_order.each do |order_array|

            order_array.each do |element|
            element = "#{element}".split(':')
            # ap element
            products << element

          end

          end

          @@all_orders << Order.new(id, products)
        end
        # ap full_order[0]

        # ap "PRODUCTS : #{products}"
        return @@all_orders
      end


      return
    end
    # order = "#{orders[0][1]}".split(';')
    # # puts "order: #{order}"
    #
    # element = "#{order[0]}".split(':')
    # # puts "element: #{element}"
    #
    #
    # product = element[0]
    # # puts "product: #{product}"
    #
    #
    # price = element[1]
    # # puts "price: #{price}"

    # Total Method
    def total
      sum = 0
      @products.values.each do |price|
        sum += price
      end
      # sum = products.values.inject(0, :+)
      total = sum + (sum * 0.075)
      return total.round(2)
    end


    # add_product method
    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # Remove product
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

orders = []

CSV.read('../support/orders.csv', 'r').each do |row|
  orders << row
end

id = orders[0][0]
# id = orders[i][0]
# puts "id : #{id}"

order = "#{orders[0][1]}".split(';')
# order = "#{orders[i][1]}".split(';')
# puts "order: #{order}"

# element = "#{order[0]}".split(':')
# # puts "element: #{element}"
#
#
# product = element[0]
# # puts "product: #{product}"
#
#
# price = element[1]
# # puts "price: #{price}"

this_order = Grocery::Order.new(id, order)
ap Grocery::Order.all
# ap this_order.products
# ap this_order.products

# puts this_order.total


# first_order = Grocery::Order.new(orders[0], products)
