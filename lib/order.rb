require 'csv'

ORDER_FILE = 'support/orders.csv'

module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
    end

    # sums product prices, adds 7.5% tax, and rounds to two decimal places
    def total
      subtotal = 0
      @products.each do |name, price|
        subtotal += price
      end
      total = (subtotal * 1.075).round(2)
      return total
    end

    # returns false if the product name is already included in the order's products,
    # adds product to the instance's product hash if not already present and returns true
    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    # reads csv file (set to orders.csv by default if no other file is given)
    # iterates through each line (array) of the csv file to parse the id and product data
    # for each line, creates a new instance of the Order class and adds it to an array of all Order instances
    def self.all(csv_file=ORDER_FILE)
      csv_array = CSV.read(csv_file, 'r')
      all_orders = []
      csv_array.each do |order|
        id = order[0].to_i
        products = Hash[order[1].split(/:|;/).each_slice(2).collect { |k, v| [k,v.to_f] }]
        new_order = Order.new(id, products)
        all_orders << new_order
      end
      return all_orders
    end

    # iterates through the array returned by the self.all method to find an order with an id equal to the provided argument
    # raises an ArgumentError if the provided id does not match an id in the array returned by self.all
    def self.find(id, csv_file=ORDER_FILE)
      Order.all(csv_file).each do |order|
        if order.id == id
          return order
        end
      end
      raise ArgumentError.new("Order #{id} could not be found in the order database.")
    end
  end
end
