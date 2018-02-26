require 'csv'
require 'awesome_print'


module Grocery
  class Order
    attr_reader :id, :products


    def initialize(id, products)
      @id = id
      @products = products
    end

    def self.products_to_string(csv_input)
      products = {}
      product_pairs = csv_input.split (";")
      product_pairs.each do |pair|
        key, value = pair.split ":"
        products[key] = value
      end
      return products

    end


    def self.all
      orders = []
      # "This is a class method."
      # This is a class method to access the class variabel
      #returns the csv file to an array with headers
      #orders_csv = CSV.read('support/orders.csv', 'r')
      orders_csv = CSV.read("support/orders.csv", 'r',headers: true).to_a

      orders_csv.each do |line|
        products = self.products_to_string(line[1])

        new_order = Grocery::Order.new(line[0], products)
        orders << new_order
      end
      return orders
    end


    def self.find(id)
      a = self.all

      if id > a.length
        return nil
      end

      if id >=1
        specific_order = a[id-1]
      elsif id < 0
        specific_order = a[id]
      else
        return nil
      end
      return specific_order

      #       def self.find(id)
      #   all.each do |order|
      #     return order if order.id == id
      #   end
      #   return nil
      # end
    end



    #this is also an instance method, not a class method
    #it should be called on an instance of the class, and it would already be instantiated by the time it got here
    def total
      sum = 0
      #put in a class level variable for total
      if !(@products.empty?) || @products !=  nil
        @products.each do |product, cost|
          sum += cost
        end
        sales_tax = 0.075
        sum = (sum + (sum * sales_tax)).round(2)
      end
      return sum
      # TODO: make changes where sum is returned
    end



    #Why this way instead of instantiating?
    #already inside of an order, order is already instantiated this is a instance method
    def add_product(product_name, product_price)
      if @products.has_key? product_name
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    #this is an instance method, which means that we don't need to call an instance of the order class before we use it, it will only be called on instances of the order, where it has already been instantiated
    def remove_product(product_name)

      if @products.has_key? product_name
        return false
      end

    end


  end
end

#ap Grocery::Order.all

#ap a
#ap b

#b.add_product('apple', 3.30)
