require 'pry'
require 'csv'
require 'awesome_print'


module Grocery
  # begin
  # rescue Grocery::FindError > e
  # end

  class FindError < ArgumentError
    def initialize(msg="Error: Order has not been created yet")
      super
    # rescue
    end
  end

  class Order
    attr_reader :id, :products

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
      # id = rand(0001..9999)
      # until @products.include?(id) != true
      #   id = rand(0001..9999)
      # end
      products = {product_name => product_price}
      products.each do |product, price|
        if @products.include? product
          return false
        else
          @products.merge!({product => price})
          return true
        end
      end
      #return  @products.merge!({product_name: product_price})
    end # Order#add_product

    def self.all
      list_all = []
      headers = ["id", "products"]
      # order_list = CSV.open('support/orders.csv', 'r', headers: true, header_converters: :symbol).each {|row| Hash[order_list.collect { |order| [order.id, order.products] } ] }
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
      self.all.each do |order|
        if id > all.length
          raise Grocery::FindError.new
        elsif
          order.id == id
          return order
        end
      end # self.all.each do
    end # Order.find
  end # Order
end # Grocery

binding.pry
