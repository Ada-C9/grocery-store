require 'pry'
require 'csv'
require 'awesome_print'


module Grocery
  # begin
  # rescue Grocery::FindError > e
  # end

  # custom error for the Order.find class method
  class FindError < ArgumentError
    def initialize(msg="Error: Order has not been created yet")
      super
    # rescue
    end
  end

  class Order
    attr_reader :id, :products
    @@list_all = []

    def initialize(id, products)
      @id = id
      @products = products
    end

    def total
      subtotal = 0
      @products.each do |product, price|
        subtotal += price
      end
      total = subtotal + (subtotal * 0.075)
      return total.round(2)
    end

    def add_product(product_name, product_price)
      products = {product_name => product_price}
      products.each do |product, price|
        if @products.include? product
          return false
        else
          @products.merge!({product => price})
          return true
        end
      end
    end # Order#add_product

    def self.list_all
      return @@list_all
    end

    def self.populate
      if @@list_all.length == 0
        @@list_all = all
      else
        return @@list_all
      end
    end

    def self.all
      list_all = []
      CSV.open('support/orders.csv', 'r', headers: true, header_converters: :symbol).each do |row|
        products = {}
        id = row[:id].to_i
        row[:products].split(';').each do |item|
          product = item.split(':')
          name = product[0]
          price = product[1].to_f
          products[name] = price
        end
        list_all << self.new(id, products)
      end
      return list_all
    end # Order.all

    def self.find(id)
      populate
      @@list_all.each do |order|
        if id > @@list_all.length
          raise Grocery::FindError.new
        elsif
          order.id == id
          return order
        end
      end # self.all.each do
    end # Order.find

  end # Order

end # Grocery
