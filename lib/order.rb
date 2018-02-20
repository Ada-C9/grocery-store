module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
      @tax = 0.075
      # @name = name
      # @price = price
    end


    def self.all
      require 'csv'
      # csv = CSV.open("../support/online_orders.csv")r
      csv = CSV.open("support/orders.csv")
      orders = []
      csv.each do |l|
        products = { }
        #puts l[1].split(';')

        product_string = l[1]
        product_smash = product_string.split(';')
        product_smash.each do |ps|
          # ps = "name1:val1"
          items = ps.split(':')
          # hash_entry = {items[0] => items[1].to_f}
          # products.push(hash_entry)
          products[items[0]] = items[1].to_f

        end  # end of product_smash.each

        order = Order.new(l[0].to_i, products)
        orders.push(order)

      end # end of csv.each
      return orders

    end

    def self.find(id)
      orders = Order.all
      orders.each do |o|
        if o.id == id
          return o
        end
      end

      return nil
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
        return false
      else
        @products[name] = price
        return true
      end
    end

  end

end
